class ImageWithDerivatives < SimpleDelegator

  def save
    derivative_asset.save
  end

  def thumbnail_success(path)
    self.has_thumbnail = true
    self.thumbnail_path = path
  end

  def medium_success(path)
    self.has_medium = true
    self.medium_path = path
  end

  def pyramidal_success(path)
    self.has_pyramidal = true
    self.pyramidal_path = path
  end

  private

  def derivative_asset
    @derivative_asset ||= AssetWithDerivatives.new(__getobj__, runners)
  end

  def runners
    @runners ||= OregonDigital::Derivatives::Runners::RunnerList.new(
      [
        injector.thumbnail_runner(id),
        injector.medium_runner(id),
        injector.pyramidal_runner(id)
      ]
    )
  end
end
