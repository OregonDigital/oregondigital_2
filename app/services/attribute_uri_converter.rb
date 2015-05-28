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
    case values
      when Array
        values = convert_attribute_list(values)
      when String
        values = to_uri(values)
    end

    @attributes[property] = values
  end

  def convert_attribute_list(values)
    values.map {|value| to_uri(value)}
  end

  def to_uri(string)
    if is_uri(string)
      RDF::URI(string)
    else
      string
    end
  end

  def is_uri(string)
    begin
      u = URI.parse(string)
      !u.host.blank? && !u.scheme.blank?
    rescue
      false
    end
  end
end
