# -*- encoding : utf-8 -*-
class SolrDocument 

  include Blacklight::Solr::Document

  use_extension(Hydra::ContentNegotiation)

  def filtered_field_values(field)
    Array(self[field]).map do |value|
      uri_filter(value).filter
    end.compact
  end

  def field_value_is_uri?(field)
    filtered_field_values(field).empty?
  end
 
  private

  def uri_filter(value)
    OregonDigital::URIFilter.new(value, MaybeURI) 
  end
end
