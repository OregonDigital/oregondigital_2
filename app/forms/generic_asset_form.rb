class GenericAssetForm
  include HydraEditor::Form
  # TODO: Put :workType back in once our editor can support URLs and/or we have
  # a "clean" graph from AF
  skip_terms = [:workType]
  self.terms = ODDataModel.properties.keys - skip_terms

  def self.permitted_params
    super << :content
  end

end
