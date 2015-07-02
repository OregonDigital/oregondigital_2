class Admin::FacetsController < AdminController
  def index
    @solr_fields = SolrFieldSummary.where(:field => "*")
  end
end
