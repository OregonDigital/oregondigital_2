class BaseUriValidator
  pattr_initialize :base_uri

  def valid?(values)
    Array.wrap(values).all? do |value|
      UriValidator.valid?(value) && value.start_with?(base_uri.to_s)
    end
  end
end
