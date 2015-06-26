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
        {:qf => all_properties.map(&:property_key)}
      end
    end

    private

    def all_properties
      [property] | property.derivative_properties.values
    end

    def property
      @property ||= SolrProperty.new(solr_name)
    end

    def solr_name
      Solrizer.solr_name(key, :stored_searchable)
    end
  end
end
