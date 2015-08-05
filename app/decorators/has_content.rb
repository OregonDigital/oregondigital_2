class HasContent < SimpleDelegator
  def class
    __getobj__.class
  end

  def attributes=(attributes)
    attributes = AttributesWithContent.new(attributes)
    if attributes.content
      self.content.content = attributes.content
      self.content.mime_type = attributes.content.mime_type
    end
    super(attributes.to_h)
  end

  class AttributesWithContent
    pattr_initialize :attributes
    def to_h
      attributes.except(:content)
    end

    def content
      if attributes[:content]
        Content.new(attributes[:content])
      end
    end
  end
  class Content < SimpleDelegator
    def mime_type
      content_type
    end
  end
end
