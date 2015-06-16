# -*- encoding : utf-8 -*-
class SolrDocument 

  include Blacklight::Solr::Document

  use_extension(Hydra::ContentNegotiation)

  def field_value_is_uri(field)
    Array(self[field]).map do |value|
      uri_filter(value).filter
    end.compact
  end

  private

  def uri_filter(value)
    OregonDigital::URIFilter.new(value, MaybeURI) 
  end
end
