module OregonDigital::Derivatives::Runners
  class DerivativeRunner
    attr_accessor :source, :path, :callback_factory, :asset, :callbacks
    def initialize(path, callback_factory)
      @path = path
      @callback_factory = callback_factory
    end

    def run(asset)
      @asset = asset
      @source = asset.streamable_content
      @callbacks = Array.wrap(callback_factory.new(asset))
      create_derivatives
      notify_callbacks
    end

    private

    def create_derivatives
      raise NotImplementedError
    end

    def notify_callbacks
      callbacks.each do |callback|
        callback.send(success_method, path)
      end
    end
    
    def success_method
      raise NotImplementedError
    end

  end
end
