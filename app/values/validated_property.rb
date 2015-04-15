class ValidatedProperty
  vattr_initialize :validated_property, :property_accessor
end

module Kernel
  def ValidatedProperty(value)
    if value.kind_of? ValidatedProperty
      value
    else
      ValidatedProperty.new(value.to_sym, value.to_sym)
    end
  end
end
