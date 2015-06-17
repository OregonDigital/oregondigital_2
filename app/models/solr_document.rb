# -*- encoding : utf-8 -*-
class SolrDocument 

  include Blacklight::Solr::Document

  use_extension(Hydra::ContentNegotiation)

  def [](value)
    if value != "id"
      NotUris.new(super)
    else
      super
    end
  end
end
