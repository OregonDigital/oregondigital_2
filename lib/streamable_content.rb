class StreamableContent < StringIO
  attr_accessor :mime_type

  def initialize(string, mime_type)
    super(string)
    self.binmode
    @mime_type = mime_type
  end

  def path
    "#{default_name}#{extension}"
  end

  private

  def extension
    Rack::Mime::MIME_TYPES.invert[mime_type]
  end

  def default_name
    "test_item"
  end
end
