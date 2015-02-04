class ImageWithDerivatives < AssetWithDerivatives

  def runners
    [
      injector.thumbnail_runner(id),
      injector.medium_runner(id),
      injector.pyramidal_runner(id)
    ]
  end

  def derivative_class
    OregonDigital::Derivatives::Generators::ImageDerivativeGenerator
  end

end
