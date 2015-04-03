class CleanRepository
  attr_reader :connection, :id_converter
  def initialize(connection, id_converter)
    @connection = CleanConnection.new(connection)
    @id_converter = id_converter
  end

  def find(id)
    connection.get(uri(id)).graph
      .delete(has_model_query)
  end

  private

  def has_model_query
    [nil, ActiveFedora::RDF::Fcrepo::Model.hasModel, nil]
  end

  def uri(id)
    id_converter.id_to_uri(id)
  end
end

class CleanConnection < SimpleDelegator
  def get(*args)
    __getobj__.get(*args) do |req|
      prefer_headers = PreferHeaders.new(req.headers["Prefer"])
      prefer_headers.omit = prefer_headers.omit | omit_uris
      req.headers["Prefer"] = prefer_headers.to_s
    end
  end

  private

  def omit_uris
    [
      "http://fedora.info/definitions/v4/repository#ServerManaged",
      "http://www.w3.org/ns/ldp#PreferContainment",
      "http://www.w3.org/ns/ldp#PreferEmptyContainer",
      "http://www.w3.org/ns/ldp#PreferMembership"
    ]
  end
end

class PreferHeaders
  attr_reader :headers_string

  def initialize(headers_string)
    @headers_string = headers_string
  end

  def omit
    @omit ||= options["omit"] || []
  end

  def prefer
    @prefer ||= options["prefer"] || []
  end

  def return
    @return ||= options["return"].first
  end

  def prefer=(vals)
    @prefer = Array(vals)
    serialize
  end

  def omit=(vals)
    @omit = Array(vals)
    serialize
  end

  def to_s
    headers_string.to_s
  end

  private

  def serialize
    head_string = []
    if self.return.present?
      head_string << "return=#{self.return}"
    end
    if omit.present?
      head_string << "omit=\"#{omit.join(" ")}\""
    end
    if prefer.present?
      head_string << "prefer=\"#{prefer.join(" ")}\""
    end
    @headers_string = head_string.join("; ")
  end

  def options
    headers_string.gsub('"',"").
      split(";").
      map{|x| x.strip.split("=")}.
      map{|x| { x[0] => x[1].split(" ") }}.
      inject({}, &:merge)
  end
end
