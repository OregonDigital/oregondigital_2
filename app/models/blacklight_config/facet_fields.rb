class BlacklightConfig
  class FacetFields
    pattr_initialize :configuration
    
    def run
      facet_fields.each do |field|
        configuration.add_facet_field "#{field.key}_ssim"
      end
      configuration.add_facet_fields_to_solr_request!
    end

    private

    def facet_fields
      @facet_fields ||= FacetField.all
    end
  end
end
