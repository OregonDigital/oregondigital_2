class SolrFieldSummary
  class Field < OpenStruct
    def derivative_properties
      @derivative_properties ||= {}
    end
  end
end
