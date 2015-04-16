class BlacklightConfig
  class DefaultConfiguration
    pattr_initialize :configuration
    def run
      configuration.default_solr_params = default_params
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
