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
