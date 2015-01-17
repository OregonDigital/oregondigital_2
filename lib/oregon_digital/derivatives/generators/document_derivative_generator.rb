module OregonDigital::Derivatives::Generators
  class DocumentDerivativeGenerator
    attr_accessor :asset, :file, :pdf_runner
    def initialize(asset, file, pdf_runner)
      @asset = asset
      @file = file
      @pdf_runner = pdf_runner
    end

    def run
      create_pdf_pages
    end

    def pdf_success(path)
      asset.has_pdf_pages = true
      asset.pdf_pages_path = path
    end

    def stream_content
      @stream_content ||= StringIO.new(file.content)
    end

    private

    def create_pdf_pages
      pdf_runner.run(stream_content, self)
    end
  end
end
