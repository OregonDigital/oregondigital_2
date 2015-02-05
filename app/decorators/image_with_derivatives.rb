class ImageWithDerivatives < SimpleDelegator

  def save
    derivative_asset.save
  end

  private

  def derivative_asset
    @derivative_asset ||= AssetWithDerivatives.new(__getobj__, derivative_class, runners)
  end

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
