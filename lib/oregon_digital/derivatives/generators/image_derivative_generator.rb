module OregonDigital::Derivatives::Generators
  class ImageDerivativeGenerator
    attr_accessor :asset, :file, :thumbnail_runner, :medium_runner, :pyramidal_runner

    def initialize(asset, file, thumbnail_runner, medium_runner, pyramidal_runner)
      @asset = asset
      @file = file
      @thumbnail_runner = thumbnail_runner
      @medium_runner = medium_runner
      @pyramidal_runner = pyramidal_runner
    end

    def run
      create_thumbnail
      create_medium
      create_pyramidal
    end

    def thumbnail_success(path)
      asset.has_thumbnail = true
      asset.thumbnail_path = path
    end

    def medium_success(path)
      asset.has_medium = true
      asset.medium_path = path
    end

    def pyramidal_success(path)
      asset.has_pyramidal = true
      asset.pyramidal_path = path
    end

    private

    def stream_content
      @stream_content ||= StringIO.new(file.content)
    end

    def create_thumbnail
      thumbnail_runner.run(stream_content, self)
    end

    def create_medium
      medium_runner.run(stream_content, self)
    end

    def create_pyramidal
      pyramidal_runner.run(stream_content, self)
    end

  end
end
