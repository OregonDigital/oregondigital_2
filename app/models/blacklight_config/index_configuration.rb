class BlacklightConfig
  class IndexConfiguration
    pattr_initialize :configuration
    def run
      configuration.index.title_field = Solrizer.solr_name('title', :symbol).to_s
      configuration.add_index_field Solrizer.solr_name('date', :symbol), :label => 'Date'
      configuration.add_index_field Solrizer.solr_name('description', :symbol), :label => 'Description'

      configuration.add_index_field "full_text_tsimv", :label => "Full Text", :highlight => true
    end
  end
end
