module OregonDigital::Derivatives::Runners
  class ThumbnailDerivativeRunner < ImageDerivativeRunner

    private

    def type
      :thumbnail
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
