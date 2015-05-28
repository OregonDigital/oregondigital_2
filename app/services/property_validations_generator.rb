class PropertyValidationsGenerator
  pattr_initialize :base_repository
  def validations
    {
      validated_property(:lcsubject) => [
        ControlledSubject.new
      ]
    }
  end

  private

  # We need to validate against the URIs, not the AT objects, so access with
  # :lcsubject_ids, but add errors to :lcsubject.
  def validated_property(property)
    ComposedValidations::ValidatedProperty.new(property, "#{property}_ids".to_sym)
  end
end
