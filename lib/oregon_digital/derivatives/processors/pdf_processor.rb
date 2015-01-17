module OregonDigital::Derivatives::Processors
  class PdfProcessor
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
      create_first_size
      create_extra_sizes
    end

    def create_first_size
      create_size(*sizes.first)
    end

    def create_extra_sizes
      sizes.to_a[1..-1].each do |name, size|
        create_size_from_xl(name, size)
      end
    end

    def create_size_from_xl(name, size)
      xl_pages.each do |xl_page|
        page = page_number(xl_page)
        extension = Pathname.new(xl_page).extname
        target = new_path_name(name, page, extension)
        ImageProcessor.new(File.open(xl_page), :size => size, :path => target).run
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

    def page_number(page)
      page.split("-").last.split(".").first
    end

    def xl_pages
      @xl_pages ||= Dir[File.join(path, "#{sizes.keys.first}*")]
    end

    def create_size(name, size)
      Docsplit.extract_images(disk_file.path, :size => size, :format => format, :output => path)
      rename_path_files(name)
    end

    def rename_path_files(name)
      Dir["#{Pathname.new(path).join('*')}"].each do |file|
        next if file.include?("page-")
        page = Pathname.new(file.split('_').last).sub_ext('').to_s
        page_path = Pathname.new(file)
        new_path = new_path_name(name, page, page_path.extname)
        File.rename(file, new_path.to_s)
      end
    end


    def temporary_file
      tempfile = Tempfile.new('document_tmp')
      tempfile.binmode
      begin
        tempfile.write(file.read)
        yield tempfile
      ensure
        tempfile.close
        tempfile.unlink
      end
    end

    def create_output_directory
      FileUtils.rm_rf path
      FileUtils.mkdir_p path
    end
  end
end
