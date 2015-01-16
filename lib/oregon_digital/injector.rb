module OregonDigital
  class Injector

    def thumbnail_runner(id)
      OregonDigital::Derivatives::Runners::ThumbnailDerivativeRunner.new(thumbnail_path(id))
    end

    def medium_runner(id)
      OregonDigital::Derivatives::Runners::MediumImageDerivativeRunner.new(medium_path(id))
    end

    def pyramidal_runner(id)
      OregonDigital::Derivatives::Runners::PyramidalDerivativeRunner.new(pyramidal_path(id))
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

    private

    def distributor_path(id, extension, path)
      distributor = OregonDigital::FileDistributor.new(id)
      distributor.extension = extension
      distributor.base_path = path
      distributor.path
    end
  end
end
