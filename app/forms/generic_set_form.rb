class GenericSetForm < GenericAssetForm
  self.model_class = GenericSet
  self.terms = [] # Terms to be edited
  self.required_fields = [] # Required fields
end

