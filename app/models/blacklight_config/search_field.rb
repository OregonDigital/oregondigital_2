class BlacklightConfig
  class SearchField
    attr_reader :key, :opts
    def initialize(key, opts={})
      @key = key
      @opts = opts
    end
    
    def label
      opts.fetch(:label, key.titleize)
    end

    def solr_parameters
      if opts[:qf]
        {:qf => opts[:qf]}
      else
        {:qf => Solrizer.solr_name(key, :searchable) }
      end
    end
  end
end
