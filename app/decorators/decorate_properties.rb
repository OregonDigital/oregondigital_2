class DecorateProperties
  pattr_initialize :resource, :property_mapper
  
  def run
    temp_resource = resource
    property_mapper.to_a.map{|x| PropertyValidator.new(*x) }.each do |p|
      temp_resource = p.decorate_resource(temp_resource)
    end
    temp_resource
  end
end

class PropertyValidator
  attr_reader :property, :validators
  def initialize(property, validators)
    @property = property
    @validators = Array.wrap(validators)
  end

  def decorate_resource(resource)
    validators.each do |validator|
      resource = WithValidatedProperty.new(resource, property, validator)
    end
    resource
  end
end
