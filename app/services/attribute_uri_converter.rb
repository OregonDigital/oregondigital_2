class AttributeURIConverter
  def initialize(attributes)
    @attributes = attributes.dup
  end

  def convert_attributes
    @attributes.each do |property, values|
      convert_attribute(property, values)
    end

    @attributes
  end

  private

  def convert_attribute(property, values)
    @attributes[property] = Array.wrap(values).map {|v| MaybeURI.new(v)}.map(&:value)
  end
end
