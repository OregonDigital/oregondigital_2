module OregonDigital::Derivatives::Runners
  class WebMDerivativeRunner < VideoDerivativeRunner

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
      "-vcodec libvpx -acodec libvorbis -g 30 -b:v 345k -ac 2 -ab 96k -ar 44100 -y"
    end

    def type
      :webm
    end
  end
end
