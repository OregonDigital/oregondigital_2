# The Label Enhancement takes URI properties and returns their preferred labels.
class LabelEnhancement
  attr_reader :raw_property
  def initialize(property)
    @raw_property = property
  end

  def property
    SolrProperty.new(solr_identifier, values)
  end

  private

  def values
    OnlyUris.new(raw_property.values).map do |value|
      NotBlank.new(resource(value).preferred_label).value
    end.compact
  end

  def solr_identifier
    "#{raw_property.key}_preferred_label_#{raw_property.solr_identifier}"
  end

  def resource(value)
    TriplePoweredResource.new(value)
  end
end
