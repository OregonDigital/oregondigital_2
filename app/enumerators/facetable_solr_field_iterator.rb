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
    flattened_derivative_properties.sort_by{|k, v| -v.distinct}
  end

  def flattened_derivative_properties
    FlatteningDerivativePropertiesIterator.new(only_data_model_keys).to_h
  end

  def only_data_model_keys
    solr_field_summary.to_h.slice(*data_model_properties)
  end

  def data_model_properties
    ODDataModel.properties.map(&:name)
  end
end
