class BlacklightConfig
  class ViewConfiguration
    pattr_initialize :configuration
    delegate :index, :to => :configuration
    def run
      index.title_field = Solrizer.solr_name("title", :displayable)
      index.display_type_field = Solrizer.solr_name('has_model', :symbol)
    end
  end
end
