module OregonDigital::Derivatives::Runners
  class DerivativeRunner
    attr_accessor :source, :path, :callbacks
    def initialize(source, path, callbacks=[])
      @source = source
      @path = path
      @callbacks = Array.wrap(callbacks)
    end

    def run
      raise NotImplementedError
    end

    private

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
