module OregonDigital::Derivatives
  class PyramidalProcessor
    attr_accessor :file, :quality, :tile_size, :path
    def initialize(file, opts={})
      @file = file
      @quality = opts.fetch(:quality, 75)
      @tile_size = opts.fetch(:tile_size, 256)
      @path = opts.fetch(:path)
      raise ArgumentError unless [file, quality, tile_size, path].select{|x| x.to_s == ""}.empty?
    end

    def run
      temporary_file do |f|
        vips_image = VIPS::Image.new(f.path)
        vips_image = vips_image.msb
        vips_image.tiff(path, vips_options)
      end
    end

    private

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

    def temporary_file
      tempfile = Tempfile.new('pyramidal_tmp')
      begin
        tempfile.write(file.read)
        yield tempfile
      ensure
        tempfile.close
        tempfile.unlink
      end
    end
  end
end
