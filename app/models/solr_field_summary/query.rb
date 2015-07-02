class SolrFieldSummary
  class Query
    attr_reader :field
    def initialize(field:)
      @field = field
    end

    def result
      @result ||= solr_result["fields"]
    end

    private

    def solr_result
      solr.send_and_receive("admin/luke", :params => solr_params)
    end

    def solr_params
      {
        :fl => field
      }
    end

    def solr
      ActiveFedora.solr.conn
    end
  end
end
