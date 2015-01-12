module OregonDigital::Derivatives
  class ImageDerivativeGenerator
    attr_accessor :asset, :file
    delegate :thumbnail_path, :medium_path, :to => :injector

    def initialize(asset, file)
      @asset = asset
      @file = file
    end

    def run
      create_thumbnail
      create_medium
    end

    def thumbnail_success(path)
      asset.has_thumbnail = true
    end

    def medium_success(path)
      asset.has_medium = true
    end

    private

    def stream_content
      @stream_content ||= StringIO.new(file.content)
    end

    def create_thumbnail
      ThumbnailDerivativeRunner.new(stream_content, thumbnail_path(asset.id), self).run
    end

    def create_medium
      MediumImageDerivativeRunner.new(stream_content, medium_path(asset.id), self).run
    end

    def injector
      @injector ||= OregonDigital.inject
    end

  end
end
