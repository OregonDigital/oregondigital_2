class FileContent < ActiveFedora::File
  def streamable_content
    StreamableContent.new(content,mime_type)
  end
end
