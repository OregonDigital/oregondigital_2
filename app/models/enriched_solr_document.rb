##
# A solr document with enrichments run against URI-based fields.
class EnrichedSolrDocument
  pattr_initialize :solr_document
  def update_document
    @update_document ||= properties.each_with_object({}) do |property, hsh|
      enhancements.new(property).properties.each do |enhance_property|
        hsh[enhance_property.property_key] ||= []
        hsh[enhance_property.property_key] |= enhance_property.values
        hsh["ubercreator_preferred_label_ssim"] ||= []
        hsh["ubercreator_ssim"] ||= []
        if enhance_property.property_key == "creator_preferred_label_ssim"
           hsh["ubercreator_preferred_label_ssim"] |= enhance_property.values
           hsh["ubercreator_ssim"] |= solr_document["creator_ssim"]
        elsif enhance_property.property_key == "author_preferred_label_ssim"
           hsh["ubercreator_preferred_label_ssim"] |= enhance_property.values
           hsh["ubercreator_ssim"] |= solr_document["author_ssim"]
        end
      end
    end.delete_if{|_, v| v.blank?}
  end

  # @return An atomic update-ready solr document.
  def to_solr
    #binding.pry
    @to_solr ||= {"id" => solr_document["id"]}.merge(
    update_document.each_with_object({}) do |(k, v), hsh|
      hsh[k] = {"set" => v}
    end)
    #binding.pry
  end

  private

  def enhancements
    CompositeEnhancementFactory.new(LabelEnhancement, AltLabelEnhancement)
  end

  def properties
    @properties ||= solr_document.map{|keys| SolrProperty.new(*keys)}
  end

end
