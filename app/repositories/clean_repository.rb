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
