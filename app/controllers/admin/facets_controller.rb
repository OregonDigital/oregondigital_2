class Admin::FacetsController < AdminController
  def index
    @solr_fields = FacetableSolrFieldIterator.new(SolrFieldSummary.where(:field => "*"))
  end
end
