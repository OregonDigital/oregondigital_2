class SolrFieldSummary
  class Field < OpenStruct
    def derivative_properties
      @derivative_properties ||= {}
    end
    def topTerms
      super || []
    end
  end
end
