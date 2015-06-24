class BlacklightConfig
  class IndexConfiguration
    pattr_initialize :configuration
    def run
      configuration.index.title_field = Solrizer.solr_name('title', :symbol).to_s
      configuration.add_index_field Solrizer.solr_name('date', :symbol), :label => 'Date'
      configuration.add_index_field Solrizer.solr_name('description', :symbol), :label => 'Description'

    end
  end
end
