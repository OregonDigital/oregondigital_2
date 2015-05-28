class Image < GenericAsset
  has_derivatives :thumbnail, :medium, :pyramidal

  def relative_image_location(abs_path)
    base_path = Pathname.new(Rails.root)
    file_path = Pathname.new(abs_path)
    return "/" + file_path.relative_path_from(base_path).to_s

  end

end
