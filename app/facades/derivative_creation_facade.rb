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
    service_locator.derivative_asset_factory.new(asset, runners, callback, stream_content) 
  end

  private

  def callback
    service_locator.derivative_callback_factory.new(asset)
  end

  def stream_content
    service_locator.streamable_content_factory.new(asset.content.content, asset.content.mime_type)
  end

  def runners
    service_locator.runner_finder.find(asset)
  end


end
