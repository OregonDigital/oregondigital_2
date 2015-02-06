class ImageWithDerivatives < SimpleDelegator
  delegate :derivative_decorator_class, :runner_list, :to => :derivative_injector

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

  def derivative_injector
    OregonDigital.derivative_injector
  end

  private

  def derivative_asset
    @derivative_asset ||= derivative_decorator_class.new(__getobj__, runners)
  end

  def runners
    @runners ||= runner_list.new(
      [
        derivative_injector.thumbnail_runner(id),
        derivative_injector.medium_runner(id),
        derivative_injector.pyramidal_runner(id)
      ]
    )
  end
end
