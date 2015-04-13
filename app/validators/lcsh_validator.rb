class LcshValidator
  def valid?(values)
    Array.wrap(values).all? do |value|
      UriValidator.valid?(value) && value.start_with?(base_uri)
    end
  end

  def message
    "contains a non-LCSH term"
  end

  private

  def base_uri
    "http://id.loc.gov/authorities/subjects"
  end
end
