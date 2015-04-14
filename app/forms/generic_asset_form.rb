class GenericAssetForm
  include HydraEditor::Form
  skip_terms = [:workType, :has_model, :create_date, :modified_date]
  self.terms = GenericAsset.properties.keys.collect {|key| key.to_sym} - skip_terms
end
