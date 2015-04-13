class UriValidator
  class << self
    def valid?(value)
      value.instance_of?(RDF::URI)
    end
  end
end
