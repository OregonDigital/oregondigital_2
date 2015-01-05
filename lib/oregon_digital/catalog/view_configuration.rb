module OregonDigital
  module Catalog
    module ViewConfiguration
      extend ActiveSupport::Concern
      included do
        configure_blacklight do |config|
          # solr field configuration for search results/index views
          config.index.title_field = solr_name('desc_metadata__title', :displayable)
          config.index.display_type_field = solr_name('has_model', :symbol)
        end
      end
    end
  end
end
