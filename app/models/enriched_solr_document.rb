class EnrichedSolrDocument
  pattr_initialize :solr_document
  def update_document
    properties.each_with_object({}) do |property, hsh|
      Array.wrap(enhancements.new(property).property).each do |enhance_property|
        hsh[enhance_property.property_key] ||= []
        hsh[enhance_property.property_key] |= enhance_property.values
      end
    end.delete_if{|_, v| v.blank?}
  end

  private

  def enhancements
    CompositeEnhancementFactory.new(LabelEnhancement)
  end

  def properties
    @properties ||= uri_properties.map{|keys| SolrProperty.new(*keys)}
  end

  def uri_properties
    solr_document.delete_if{|_, v| !Array.wrap(v).any?{|x| x.to_s.start_with?("http")}}
  end

end