module OregonDigital
  class DerivativeInjector
    def thumbnail_runner(id)
      OregonDigital::Derivatives::Runners::ThumbnailDerivativeRunner.new(thumbnail_path(id), derivative_callback_factory)
    end

    def medium_runner(id)
      OregonDigital::Derivatives::Runners::MediumImageDerivativeRunner.new(medium_path(id), derivative_callback_factory)
    end

    def pyramidal_runner(id)
      OregonDigital::Derivatives::Runners::PyramidalDerivativeRunner.new(pyramidal_path(id), derivative_callback_factory)
    end

    def pdf_pages_runner(id)
      OregonDigital::Derivatives::Runners::PdfRunner.new(pdf_path(id), derivative_callback_factory)
    end

    def ocr_runner(id)
      OregonDigital::Derivatives::Runners::OcrDerivativeRunner.new(ocr_path(id), derivative_callback_factory)
    end

    def ocr_path(id)
      ocr_base = pdf_path(id)
      Pathname.new(ocr_base).join("ocr.html").to_s
    end

    def thumbnail_path(id)
      thumbnail_base = Rails.root.join("media", "thumbnails")
      distributor_path(id, '.jpg', thumbnail_base)
    end

    def medium_path(id)
      medium_base = Rails.root.join("media", "medium-images")
      distributor_path(id, '.jpg', medium_base)
    end

    def pyramidal_path(id)
      pyramidal_base = Rails.root.join("media", "pyramidal")
      distributor_path(id, '.tiff', pyramidal_base)
    end

    def pdf_path(id)
      pdf_base = Rails.root.join("media", "documents")
      distributor_path(id, '', pdf_base)
    end

    def derivative_callback_factory
      OregonDigital::Derivatives::DerivativeCallback
    end

    def runner_list
      OregonDigital::Derivatives::Runners::RunnerList
    end

    private

    def distributor_path(id, extension, path)
      distributor = OregonDigital::FileDistributor.new(id)
      distributor.extension = extension
      distributor.base_path = path
      distributor.path
    end
  end
end
