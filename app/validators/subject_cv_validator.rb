class SubjectCvValidator
  delegate :message, :to => :or_validator
  def valid?(value)
    or_validator.valid?(value)
  end

  private

  def or_validator
    @or_validator ||= OrValidator.new(validators)
  end

  def validators
    [
      LcshValidator.new,
      OpaqueNsSubjectValidator.new
    ]
  end
end
