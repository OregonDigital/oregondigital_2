module OregonDigital::Derivatives
  class ImageProcessor
    attr_accessor :file, :size, :format, :quality, :path
    def initialize(file, options={})
      @file = file
      @file.rewind if @file.respond_to?(:rewind)
      @size = options.fetch(:size, "120x120>")
      @format = options.fetch(:format, "jpeg")
      @quality = options.fetch(:quality, "85")
      @path = options.fetch(:path).to_s
      raise ArgumentError unless [file, size, format, path].select{|x| x.to_s == ""}.empty?
    end

    def run
      resize_image
      convert_file
      write_file
    end

    private

    def resize_image
      image_transformer.resize(size) if size.present?
    end

    def write_file
      stream = StringIO.new
      image_transformer.write(stream)
      stream.rewind
      File.open(path, 'wb') do |f|
        f.write stream.read
      end
    end

    def convert_file
      image_transformer.format(format)
      image_transformer.quality(quality.to_s) if quality
    end

    def image_transformer
      @image_transformer ||= MiniMagick::Image.read(file)
    end
  end
end
