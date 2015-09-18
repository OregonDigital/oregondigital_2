module OregonDigital::Derivatives::Processors
  class VideoProcessor < Processor
    attr_accessor :file, :scale, :cli_args, :path
    def initialize(file, options={})
      @file = file
      @scale = options.fetch(:scale)
      @cli_args = options.fetch(:cli_args).to_s
      @path = options.fetch(:path).to_s
      raise ArgumentError unless [file, scale, cli_args, path].select{|x| x.to_s == ""}.empty?
    end

    def run
      create_path
      process_derivative
    end

    private

    def create_path
      FileUtils.mkdir_p(Pathname.new(path).dirname)
    end

    def process_derivative
      temporary_file {|f| convert f}
    end

    def convert(f)
      execute_command(%Q|ffmpeg -i "#{f.path}" scale=#{scale} #{cli_args} "#{path}"|)
    end

    def execute_command(cmd)
      result = `#{cmd} 2>&1`
      raise error_message(cmd, result) if $?.exitstatus != 0
    end

    def error_message(cmd, result)
      "Error raised by ffmpeg: `#{cmd}`: #{result}"
    end
  end
end
