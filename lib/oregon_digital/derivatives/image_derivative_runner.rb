module OregonDigital::Derivatives
  class ImageDerivativeRunner < DerivativeRunner
    def run
      ImageProcessor.new(source, options).run
      notify_callbacks
    end

    private

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
