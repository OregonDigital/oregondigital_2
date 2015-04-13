class LcshValidator
  def valid?(value)
    UriValidator.valid?(value) && value.start_with?(base_uri)
  end

  private

  def base_uri
    "http://id.loc.gov/authorities/subjects"
  end
end
