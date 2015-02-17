module OregonDigital::Derivatives::Runners
  class OcrDerivativeRunner < DerivativeRunner
    def create_derivatives
      OregonDigital::Derivatives::Processors::OcrProcessor.new(source, options).run
    end

    def options
      {
        :path => path
      }
    end

    def success_method
      :ocr_success
    end
  end
end
