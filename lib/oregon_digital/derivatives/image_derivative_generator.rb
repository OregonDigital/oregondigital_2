module OregonDigital::Derivatives
  class ImageDerivativeGenerator
    attr_accessor :asset, :file, :injector
    delegate :thumbnail_path, :to => :injector

    def initialize(asset, file)
      @asset = asset
      @file = file
    end

    def run
      create_thumbnail
    end

    def thumbnail_success(path)
      asset.has_thumbnail = true
    end

    private

    def stream_content
      @stream_content ||= StringIO.new(file.content)
    end

    def create_thumbnail
      ThumbnailDerivativeRunner.new(stream_content, thumbnail_path(asset.id), self).run
    end

    def injector
      @injector ||= OregonDigital.inject
    end

  end
end
