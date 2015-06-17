# -*- encoding : utf-8 -*-
class SolrDocument 

  include Blacklight::Solr::Document

  use_extension(Hydra::ContentNegotiation)

  def [](value)
    # Necessary because id returns a singular value, it can't return an array.
    if value != "id"
      NotUris.new(super).to_a
    else
      super
    end
  end
end
