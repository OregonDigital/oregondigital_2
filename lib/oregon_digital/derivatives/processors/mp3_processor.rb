module OregonDigital::Derivatives::Processors
  class Mp3Processor < Processor
    attr_accessor :file, :format, :path
    def initialize(file, options={})
      @file = file
      @format = options.fetch(:format, "mp3")
      @path = options.fetch(:path).to_s
      raise ArgumentError unless [file, format, path].select{|x| x.to_s == ""}.empty?
    end

    def run
      create_path
      create_derivative
    end

    private

    def create_path
      FileUtils.mkdir_p(Pathname.new(path).dirname)
    end

    def create_derivative
      temporary_file {|file| convert_file(file) }
    end

    def convert_file(file)
      ffmpeg_command(%Q|ffmpeg -i "#{file.path}" "#{path}"|)
    end

    def ffmpeg_command(command)
      result = `#{command} 2>&1`
      raise error_message(command, result) if $?.exitstatus != 0
    end
    
    def error_message(command, result)
      "Error raised while processing ffmpeg command '#{command}' : '#{result}'"
    end
  end
end
