require 'vips'
module OregonDigital::Derivatives::Processors
  class PyramidalProcessor < Processor
    attr_accessor :file, :quality, :tile_size, :path
    def initialize(file, opts={})
      @file = file
      @file.rewind if @file.respond_to?(:rewind)
      @quality = opts.fetch(:quality, 75)
      @tile_size = opts.fetch(:tile_size, 256)
      @path = opts.fetch(:path)
      raise ArgumentError unless [file, quality, tile_size, path].select{|x| x.to_s == ""}.empty?
    end

    def run
      temporary_file do |f|
        build_pyramidal(f)
      end
    end

    private

    def build_pyramidal(temporary_file)
      vips_image = VIPS::Image.new(temporary_file.path)
      vips_image = vips_image.msb
      FileUtils.mkdir_p(Pathname.new(path).dirname) # VIPS doesn't make one.
      vips_image.tiff(path, vips_options)
    end

    def vips_options
      {
        :compression => :jpeg,
        :layout       => :tile,
        :multi_res    => :pyramid,
        :quality      => quality,
        :tile_size    => dimensions
      }
    end

    def dimensions
      [tile_size, tile_size]
    end

  end
end
