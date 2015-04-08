class Image < GenericAsset
  has_derivatives :thumbnail, :medium, :pyramidal

end
