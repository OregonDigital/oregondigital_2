module OregonDigital::Derivatives::Runners
  class Mp4DerivativeRunner < VideoDerivativeRunner

    private

    def create_derivatives
      OregonDigital::Derivatives::Processors::VideoProcessor.new(source, options).run
    end

    def options
      {
        :scale => scale(320, 320),
        :cli_args => cli_args,
        :path => path
      }
    end

    def cli_args
      "-vcodec libx264 -acodec libfdk_aac -g 30 -b:v 345k -ac 2 -ab 96k -ar 44100 -y"
    end

    def type
      :mp4
    end
  end
end
