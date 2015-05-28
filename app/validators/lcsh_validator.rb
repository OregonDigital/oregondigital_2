class LcshValidator
  delegate :valid_value?, :to => :validator

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
