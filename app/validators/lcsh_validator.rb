class LcshValidator
  def valid?(values)
    validator.valid?(values)
  end

  def message
    "contains a non-LCSH term"
  end

  private

  def validator
    @validator ||= BaseUriValidator.new(base_uri)
  end

  def base_uri
    "http://id.loc.gov/authorities/subjects"
  end
end
