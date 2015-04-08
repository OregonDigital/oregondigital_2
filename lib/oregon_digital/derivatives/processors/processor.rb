module OregonDigital::Derivatives::Processors
  class Processor
    def temporary_file
      tempfile = Tempfile.new(["pyramidal_tmp","#{File.extname(file.path)}"])
      tempfile.binmode
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
