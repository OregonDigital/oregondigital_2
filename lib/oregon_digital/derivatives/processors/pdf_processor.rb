module OregonDigital::Derivatives::Processors
  class PdfProcessor < Processor
    attr_accessor :file, :path, :disk_file, :format, :sizes
    def initialize(file, options={})
      @file = file
      @file.rewind if @file.respond_to?(:rewind)
      @path = options.fetch(:path).to_s
      @format = options.fetch(:format, 'jpg')
      @sizes = options.fetch(:sizes, default_sizes)
      raise ArgumentError unless [file, path].select{|x| x.to_s == ""}.empty?
    end

    def run
      create_output_directory
      temporary_file do |f|
        @disk_file = f
        create_images
      end
    end

    private

    def create_images
      Docsplit.extract_images(disk_file.path, :size => sizes.values, :rolling => true, :format => format, :output => path)
      rename_files
      cleanup_directories
    end

    def rename_files
      files = Dir[File.join(path, "**", "*")]
      files.each do |file|
        next if File.directory?(file)
        page = Pathname.new(file.split('_').last).sub_ext('').to_s
        page_path = Pathname.new(file)
        size_name = page_path.dirname.basename.to_s
        name = sizes.find{|k, v| v == size_name}.first
        new_path = new_path_name(name, page, page_path.extname)
        File.rename(file, new_path.to_s)
      end
    end

    def cleanup_directories
      Dir[File.join(path, "*")].select{|x| File.directory?(x)}.each do |dir|
        FileUtils.rm_rf(dir)
      end
    end

    def default_sizes
      {
        'x-large' => '1500x',
        'large' => '1000x',
        'normal' => '500x',
        'small' => '180x'
      }
    end

    def new_path_name(name, page, extension)
      File.join(path, "#{name}-page-#{page}#{extension}")
    end

    def create_output_directory
      FileUtils.rm_rf path
      FileUtils.mkdir_p path
    end
  end
end
