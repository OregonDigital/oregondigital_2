module OregonDigital::Derivatives::Runners
  class PdfRunner < DerivativeRunner
    def create_derivatives
      OregonDigital::Derivatives::Processors::PdfProcessor.new(source, options).run
    end

    def options
      {
        :path => path
      }
    end

    def success_method
      :pdf_success
    end
  end
end
