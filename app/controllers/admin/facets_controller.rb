class Admin::FacetsController < AdminController
  def index
    @solr_fields = iterator_factory.new(all_solr_fields)
  end

  private

  def all_solr_fields
    SolrFieldSummary.where(:field => "*")
  end

  def iterator_factory
    FacetableSolrFieldIterator
  end
end
