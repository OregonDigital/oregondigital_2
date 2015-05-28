class OpaqueNsSubjectValidator
  delegate :valid_value?, :to => :validator

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
