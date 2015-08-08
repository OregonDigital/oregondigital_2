##
# A solr document with enrichments run against URI-based fields.
class EnrichedSolrDocument
  pattr_initialize :solr_document
  def update_document
    @update_document ||= document_properties.each_with_object({}) do |enhance_property, hsh|
      hsh[enhance_property.property_key] ||= []
      hsh[enhance_property.property_key] |= enhance_property.values
    end.delete_if{|_, v| v.blank?}
  end

  def derived_document
    update_document
  end

  # @return An atomic update-ready solr document.
  def to_solr
    @to_solr ||= {"id" => solr_document["id"]}.merge(
    derived_document.each_with_object({}) do |(k, v), hsh|
      hsh[k] = {"set" => v}
    end)
  end

  private

  def document_properties
    derived_properties + enhanced_properties
  end

  def derived_properties
    enhanced_properties.flat_map do |enhanced_property|
      property_deriver.new(enhanced_property).properties
    end
  end

  def enhanced_properties
    properties.flat_map do |property|
      enhancements.new(property).properties
    end.select{|x| !x.values.blank?}
  end

  def property_deriver
    PropertyDeriver
  end

  def enhancements
    CompositeEnhancementFactory.new(LabelEnhancement, AltLabelEnhancement)
  end

  def properties
    @properties ||= solr_document.map{|keys| SolrProperty.new(*keys)}
  end

end
