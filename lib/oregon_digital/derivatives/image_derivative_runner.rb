module OregonDigital::Derivatives
  class ImageDerivativeRunner
    attr_accessor :source, :path, :callbacks
    def initialize(source, path, callbacks=[])
      @source = source
      @path = path
      @callbacks = Array.wrap(callbacks)
    end

    def run
      ImageProcessor.new(source, options).run
      notify_callbacks
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

    def options
      {
        :size => size,
        :format => format,
        :quality => quality,
        :path => path
      }
    end

    def size
      "120x120>"
    end

    def format
      'jpeg'
    end

    def quality
      '75'
    end

  end
end
