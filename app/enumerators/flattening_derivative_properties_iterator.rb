class FlatteningDerivativePropertiesIterator
  include Enumerable
  pattr_initialize :solr_field_summary
  def each
    solr_field_summary.each do |prop, field|
      yield [prop, NoDerivativeProperties.new(field)]
      field.derivative_properties.each do |derivative_property, derivative_field|
        property = [prop, derivative_property].map(&:to_s).join("_").to_sym
        yield [property, derivative_field]
      end
    end
  end
end
