class GenericAssetForm
  include HydraEditor::Form
  # TODO: Put :workType back in once our editor can support URLs and/or we have
  # a "clean" graph from AF
  #
  class << self
    def factory=(factory)
      @factory = factory
    end
  end

  def self.factory=(factory)
    @factory = factory
  end
 
  skip_terms = [:workType]
  self.terms = ODDataModel.simple_properties.keys - skip_terms
  self.factory = OregonDigital::Fields::InputFactory

  def self.permitted_params
    super << :content
  end

end
