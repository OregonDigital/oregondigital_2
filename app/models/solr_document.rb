# -*- encoding : utf-8 -*-
class SolrDocument 

  include Blacklight::Solr::Document

  use_extension(Hydra::ContentNegotiation)

  def field_value_is_uri(field)
    Array(self[field]).map do |value|
      maybe_uri(value).uri?
    end.include?(true)
  end

  private

  def maybe_uri(value)
    MaybeURI.new(value) 
  end
end
