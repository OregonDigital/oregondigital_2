class SolrFieldSummary
  class Field < OpenStruct
    def distinct
      super || 0
    end

    def topTerms
      super || []
    end
  end
end
