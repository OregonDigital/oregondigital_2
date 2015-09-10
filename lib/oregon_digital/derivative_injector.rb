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

    def webm_runner(id)
      OregonDigital::Derivatives::Runners::WebMDerivativeRunner.new(webm_path(id), derivative_callback_factory)
    end

    def mp4_runner(id)
      OregonDigital::Derivatives::Runners::Mp4DerivativeRunner.new(mp4_path(id), derivative_callback_factory)
    end

    def video_thumbnail_runner(id)
      OregonDigital::Derivatives::Runners::VideoThumbnailDerivativeRunner.new(thumbnail_path(id), derivative_callback_factory)
    end

    def ocr_path(id)
      pdf_path(id).join("ocr.html")
    end

    def thumbnail_path(id)
      thumbnail_base = derivative_base.join("thumbnails")
      distributor_path(id, '.jpg', thumbnail_base)
    end

    def medium_path(id)
      medium_base = derivative_base.join("medium-images")
      distributor_path(id, '.jpg', medium_base)
    end

    def pyramidal_path(id)
      pyramidal_base = derivative_base.join("pyramidal")
      distributor_path(id, '.tiff', pyramidal_base)
    end

    def pdf_path(id)
      pdf_base = derivative_base.join("documents")
      distributor_path(id, '', pdf_base)
    end

    def webm_path(id)
      webm_base = derivative_base.join("video")
      distributor_path(id, '.webm', webm_base)
    end

    def mp4_path(id)
      mp4_base = derivative_base.join("video")
      distributor_path(id, '.mp4', mp4_base)
    end

    def derivative_base
      Rails.root.join("media")
    end

    def derivative_callback_factory
      OregonDigital::Derivatives::DerivativeCallback
    end

    def runner_list
      delayed_runner_factory.new(persisting_runner_factory.new(OregonDigital::Derivatives::Runners::RunnerList), derivative_job)
    end

    def runner_finder_factory
      OregonDigital::Derivatives::RunnerFinder
    end

    def lazy_runner_factory
      OregonDigital::Derivatives::LazyRunner
    end

    private

    def delayed_runner_factory
      OregonDigital::Derivatives::DelayedRunner::Factory
    end

    def derivative_job
      CreateDerivativesJob
    end

    def persisting_runner_factory
      OregonDigital::Derivatives::PersistingRunner::Factory
    end

    def distributor_path(id, extension, path)
      distributor = OregonDigital::FileDistributor.new(id)
      distributor.extension = extension
      distributor.base_path = path
      distributor.path
    end
  end
end
