module OregonDigital::Derivatives::Runners
  class ImageDerivativeRunner < DerivativeRunner

    private

    def create_derivatives
      OregonDigital::Derivatives::Processors::ImageProcessor.new(source, options).run
    end

    def options
      {
        :size => size,
        :format => format,
        :quality => quality,
        :path => path
      }
    end

    def format
      'jpeg'
    end

    def quality
      '75'
    end

  end
end
