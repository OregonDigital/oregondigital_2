class BlacklightConfig
  class DefaultConfiguration
    pattr_initialize :configuration
    def run
      configuration.default_solr_params = default_params
      configuration.index.title_field = 'title_tesim'
      configuration.add_index_field Solrizer.solr_name('date', :stored_searchable, type: :string), :label => 'Date'
      configuration.add_index_field Solrizer.solr_name('description', :stored_searchable, type: :string), :label => 'Description'

    end

    private

    def default_params
      {
        :qt => 'search',
        :rows => 10,
        :hl => true,
        :"hl.fl" => "full_text_tsimv",
        :"hl.useFastVectorHighlighter" => true
      }
    end
  end
end
