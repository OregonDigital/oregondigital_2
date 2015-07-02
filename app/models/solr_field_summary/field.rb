class SolrFieldSummary
  class Field < OpenStruct
    def derivative_properties
      @derivative_properties ||= {}
    end

    def distinct
      super || 0
    end

    def topTerms
      super || []
    end
  end
end
