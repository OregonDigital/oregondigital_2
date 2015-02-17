module OregonDigital::Derivatives::Processors
  class OcrProcessor < Processor
    attr_accessor :file, :path
    def initialize(file, options={})
      @file = file
      @path = options.fetch(:path)
    end

    def run
      temporary_file do |f|
        create_path
        result = `pdftotext -enc UTF-8 '#{f.path}' '#{path}' -bbox 2>&1`
        raise error_message(result) if $?.exitstatus != 0
      end
    end

    def error_message(result)
      "Error raised by pdftotext: #{result}"
    end

    def create_path
      FileUtils.mkdir_p Pathname.new(path).dirname
    end
  end
end
