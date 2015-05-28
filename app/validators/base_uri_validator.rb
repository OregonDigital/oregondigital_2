class BaseUriValidator
  pattr_initialize :base_uri

  def valid_value?(values)
    Array.wrap(values).all? do |value|
      UriValidator.valid_value?(value) && value.start_with?(base_uri.to_s)
    end
  end

  def message
    "is not in the base uri #{base_uri}"
  end
end
