class PropertyDeriver
  pattr_initialize :base_property

  def properties
    sub_property_properties + [base_property.derived_key]
  end

  private

  def sub_property_properties
    sub_properties.map do |property|
      name = property.to_s.split("/").last.downcase
      s = SolrProperty.new("#{name}__#{base_property.derivative_type}_ssim")
      SolrProperty.new(s.derived_key.property_key, base_property.values)
    end
  end

  def predicate
    @predicate ||= ODDataModel.properties.find{|x| x.name.to_s == base_property.base}.try(:predicate)
  end

  def resource
    if predicate
      @resource ||= TriplePoweredResource.new(predicate)
    else
      ActiveTriples::Resource.new
    end
  end

  def sub_properties
    @sub_properties ||= resource.get_values(RDF::RDFS.subPropertyOf).map(&:rdf_subject)
  end
end
