class MaybeURI
  pattr_initialize :raw_value

  def value
    if is_uri?
      uri
    else
      raw_value
    end
  end

  private

  def is_uri?
    String === raw_value && !uri.scheme.blank? && !uri.host.blank?
  end

  def uri
    @uri ||= RDF::URI(raw_value)
  end
end
