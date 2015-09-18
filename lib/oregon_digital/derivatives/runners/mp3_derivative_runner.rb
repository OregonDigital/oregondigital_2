module OregonDigital::Derivatives::Runners
  class Mp3DerivativeRunner < DerivativeRunner
    def create_derivatives
      OregonDigital::Derivatives::Processors::Mp3Processor.new(source, options).run
    end

    def options
      {
        :path => path 
      }
    end

    def type
      :mp3
    end
  end
end
