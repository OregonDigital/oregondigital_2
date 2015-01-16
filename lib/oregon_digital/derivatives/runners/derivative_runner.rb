module OregonDigital::Derivatives::Runners
  class DerivativeRunner
    attr_accessor :source, :path, :callbacks
    def initialize(path)
      @source = source
      @path = path
      @callbacks = Array.wrap(callbacks)
    end

    def run(source, callbacks)
      @source = source
      @callbacks = Array.wrap(callbacks)
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
