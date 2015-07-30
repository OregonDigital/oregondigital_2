# -*- encoding : utf-8 -*-
class SolrDocument 

  include Blacklight::Solr::Document

  use_extension(Hydra::ContentNegotiation)

  def [](key)
    property(key).values
  end

  def derivative_paths
    @derivative_paths ||= SolrDocumentDerivativePaths.new(self)
  end

  private

  def property(key)
    if key == "id"
      SingularSolrProperty.new(key, _source[key])
    elsif uncasted_keys.include?(SolrProperty.new(key).key)
      SolrProperty.new(key, _source[key])
    else
      EnrichedSolrPropertyResult.new(key, _source)
    end
  end

  def uncasted_keys
    ODDataModel.string_properties
  end
end

