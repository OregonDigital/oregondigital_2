module OregonDigital::Derivatives::Runners
  class VideoThumbnailDerivativeRunner < VideoDerivativeRunner

    private

    def create_derivatives
      OregonDigital::Derivatives::Processors::VideoProcessor.new(source, options).run
    end

    def options
      {
        :scale => scale(120, 120),
        :cli_args => cli_args,
        :path => path
      }
    end

    def cli_args
      "-vcodec mjpeg -itsoffset -2 -vframes 1 -an -f rawvideo -y"
    end

    def type
      :thumbnail
    end
  end
end
