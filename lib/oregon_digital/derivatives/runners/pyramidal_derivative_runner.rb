module OregonDigital::Derivatives::Runners
  class PyramidalDerivativeRunner < DerivativeRunner

    private

    def create_derivatives
      OregonDigital::Derivatives::Processors::PyramidalProcessor.new(source, options).run
    end

    def options
      {
        :quality => quality,
        :tile_size => tile_size,
        :path => path
      }
    end

    def quality
      75
    end
    
    def tile_size
      256
    end

    def success_method
      :pyramidal_success
    end
  end
end
