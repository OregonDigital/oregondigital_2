class GenericAssetForm
  include HydraEditor::Form
  delegate :validators, :to => :model

  attr_writer :template

  # TODO: Put :workType back in once our editor can support URLs and/or we have
  # a "clean" graph from AF
  skip_terms = [:workType, :oembed]
  self.terms = ODDataModel.simple_properties.keys - skip_terms

  def self.permitted_params
    super << :content
  end

  def property_hint(property)
    Array.wrap(validators[property]).map(&:description).compact.to_sentence
  end

  def has_content?
    model.content.has_content?
  end

  def template
    @template ||= NullFormTemplate.new(self.class.terms)
  end

  def template_terms
    template.visible_property_names
  end
end

# Provides a compatible API for using forms that have no template
class NullFormTemplate
  pattr_initialize :property_names

  def id
    nil
  end

  def visible_property_names
    property_names
  end
end
