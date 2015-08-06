class GenericAssetForm
  include HydraEditor::Form
  delegate :validators, :to => :model
  # TODO: Put :workType back in once our editor can support URLs and/or we have
  # a "clean" graph from AF
  skip_terms = [:workType, :oembed]
  self.terms = ODDataModel.simple_properties.keys - skip_terms

  def self.permitted_params
    super + [:content, :reviewed]
  end

  def property_hint(property)
    Array.wrap(validators[property]).map(&:description).compact.to_sentence
  end

  def has_content?
    model.content.has_content?
  end

end
