class MaybeURI
  pattr_initialize :raw_value

  def value
    if uri?
      uri
    else
      raw_value
    end
  end

  private

  def uri?
    String === raw_value && !uri.scheme.blank? && !uri.host.blank?
  end

  def uri
    @uri ||= RDF::URI(raw_value)
  end
end
