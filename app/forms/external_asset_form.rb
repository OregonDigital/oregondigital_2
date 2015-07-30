class ExternalAssetForm < GenericAssetForm
  self.model_class = ExternalAsset
  self.terms += [:oembed]
end
