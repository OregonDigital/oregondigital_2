class UriValidator
  class << self
    def valid_value?(value)
      value.instance_of?(RDF::URI)
    end
  end
end
