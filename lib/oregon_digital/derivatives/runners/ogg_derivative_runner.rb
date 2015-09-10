module OregonDigital::Derivatives::Runners
  class OggDerivativeRunner < DerivativeRunner
    def create_derivatives
      OregonDigital::Derivatives::Processors::OggProcessor.new(source, options).run
    end

    def options
      {
        :path => path 
      }
    end

    def type
      :ogg
    end
  end
end
