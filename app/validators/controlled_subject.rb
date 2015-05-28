##
# ControlledSubject is a Controlled Vocabulary.
# It responds to both the Validator interface (#message/#valid_value?) and
# #label/#description to describe that vocabulary.
class ControlledSubject
  delegate :message, :valid_value?, :to => :or_validator

  def label
    "Controlled Subject"
  end

  def description
    or_validator.message
  end

  private

  def or_validator
    @or_validator ||= ComposedValidations::OrValidator.new(validators)
  end

  def validators
    [
      LcshValidator.new,
      OpaqueNsSubjectValidator.new,
      BaseUriValidator.new("http://vocab.getty.edu/tgn/")
    ]
  end
end
