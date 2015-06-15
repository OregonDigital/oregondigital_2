# -*- encoding : utf-8 -*-
class SolrDocument 

  include Blacklight::Solr::Document

  use_extension(Hydra::ContentNegotiation)

  def uri_free_value(field)
    Array(self[field]).map do |value|
      uri_remover(value).to_s
    end
  end

  private

  def uri_remover(value)
    OregonDigital::URIRemover.new(value)
  end
end
