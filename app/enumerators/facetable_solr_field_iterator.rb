class FacetableSolrFieldIterator
  include Enumerable
  pattr_initialize :solr_field_summary

  def each
    sorted.each do |s|
      yield s
    end
  end

  private

  def sorted
    only_data_model_keys.sort_by{|k, v| -v.distinct}
  end

  def only_data_model_keys
    solr_field_summary.to_h.slice(*good_keys)
  end

  def good_keys
    (data_model_properties | derivative_keys).map(&:to_sym)
  end

  def derivative_keys
    data_model_properties.flat_map do |property|
      s = SolrProperty.new(property.to_s+"_ssim")
      s.derivative_properties.values.map(&:key)
    end.flat_map do |property|
      s = SolrProperty.new("#{property}_ssim")
      [s.key, s.derived_key.key]
    end
  end

  def data_model_properties
    ODDataModel.properties.map(&:name)
  end
end
