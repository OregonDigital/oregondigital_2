class DerivativeCreationFacade
  attr_reader :service_locator, :asset

  def self.call(asset, service_locator)
    new(asset, service_locator).built_asset
  end

  def initialize(asset, service_locator)
    @asset = asset
    @service_locator = service_locator
  end

  def built_asset
    service_locator.derivative_asset_factory.new(asset, runner_finder, callback) 
  end

  private

  def callback
    service_locator.derivative_callback_factory.new(asset)
  end

  def runner_finder
    service_locator.runner_finder
  end

end
