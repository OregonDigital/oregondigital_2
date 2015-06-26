class EnrichedSolrPropertyResult
  pattr_initialize :key, :document
  delegate :derivative_properties, :to => :property

  def values
    NotUris.new(all_values).to_a
  end

  private

  def property
    @property ||= SolrProperty.new(key, document[key])
  end

  def all_values
    enriched_values | property.values
  end

  def enriched_properties
    [
      derivative_properties[:preferred_label]
    ]
  end

  def enriched_values
    enriched_properties.flat_map do |property|
      document[property.property_key]
    end.compact
  end
end
