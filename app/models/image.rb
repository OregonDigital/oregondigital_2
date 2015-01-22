class Image < GenericAsset
  has_derivatives :thumbnail, :medium, :pyramidal

  private

  def derivative_class
    OregonDigital::Derivatives::Generators::ImageDerivativeGenerator
  end

  def derivative_creator
    derivative_class.new(self, content, injector.thumbnail_runner(id), injector.medium_runner(id), injector.pyramidal_runner(id))
  end

end
