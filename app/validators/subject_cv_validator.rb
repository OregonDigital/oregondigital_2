class SubjectCvValidator
  delegate :message, :to => :or_validator
  def valid?(value)
    or_validator.valid?(value)
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
