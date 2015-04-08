class StreamableContent < StringIO
  attr_accessor :content, :mime_type

  def initialize(content, mime_type)
    @content = content
    super(string)
    self.binmode
    @mime_type = mime_type
  end

  def path
    "#{default_name}#{extension}"
  end

  private

  def string
    return content.read if content.respond_to?(:read)
    content
  end

  def extension
    Rack::Mime::MIME_TYPES.invert[mime_type]
  end

  def default_name
    "test_item"
  end
end
