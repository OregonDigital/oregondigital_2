class OpaqueNsSubjectValidator
  def valid?(values)
    validator.valid?(values)
  end

  def message
    "contains a non opaque namespace term"
  end

  private

  def validator
    @validator ||= BaseUriValidator.new(base_uri)
  end

  def base_uri
    "http://opaquenamespace.org/ns/subject"
  end
end
