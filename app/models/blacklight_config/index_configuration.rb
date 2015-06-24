class BlacklightConfig
  class IndexConfiguration
    pattr_initialize :configuration
    def run
      configuration.index.title_field = 'title_tesim'
      configuration.add_index_field Solrizer.solr_name('date', :stored_searchable, type: :string), :label => 'Date'
      configuration.add_index_field Solrizer.solr_name('description', :stored_searchable, type: :string), :label => 'Description'

    end
  end
end
