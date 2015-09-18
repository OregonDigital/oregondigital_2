class BlacklightConfig
  class FacetFields
    pattr_initialize :configuration
    
    def run
      facet_fields.each do |field|
        configuration.add_facet_field ActiveFedora::SolrQueryBuilder.solr_name(field.key, :symbol), :label => field.view_label
      end
      FacetGroup.uber_properties.each do |property|
        property.each do |key,val|
          configuration.add_facet_field Solrizer.solr_name(key.to_s, :symbol), :label => val
        end
      end
      configuration.add_facet_fields_to_solr_request!
    end

    private

    def facet_fields
      @facet_fields ||= FacetField.all
    end
  end
end
