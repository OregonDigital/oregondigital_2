##
# A solr document with enrichments run against URI-based fields.
# do I need to make sure this runs even when there are no labels to add? I dont think so...***********************************************
class EnrichedSolrDocument
  pattr_initialize :solr_document
  def update_document
    @update_document ||= properties.each_with_object({}) do |property, hsh|
      enhancements.new(property).properties.each do |enhance_property|
        hsh[enhance_property.property_key] ||= []
        hsh[enhance_property.property_key] |= enhance_property.values
        fgproperties.each do |fgproperty|
          if enhance_property_key == FacetGroup.preflabel(fgproperty.name)
              hsh[FacetGroup.pref_label(fgproperty.uberfield)] ||= []
              hsh[FacetGroup.ssim(fgproperty.uberfield)] ||= []
              hsh[FacetGroup.pref_label(fgproperty.uberfield)] |= enhance_property.values
              hsh[FacetGroup.ssim(fgproperty.uberfield)] |= solr_document[FacetGroup.ssim(fgproperty.name)] #want to get the uri
          end
        end
      end
    end.delete_if{|_, v| v.blank?}
  end

  # @return An atomic update-ready solr document.
  def to_solr
    @to_solr ||= {"id" => solr_document["id"]}.merge(
    update_document.each_with_object({}) do |(k, v), hsh|
      hsh[k] = {"set" => v}
    end)
  end

  private

  def enhancements
    CompositeEnhancementFactory.new(LabelEnhancement, AltLabelEnhancement)
  end

  def properties
    @properties ||= solr_document.map{|keys| SolrProperty.new(*keys)}
  end

  def fgproperties
    @fgproperties ||= FacetGroup.properties
  end
end
