class HasContent < SimpleDelegator
  def class
    __getobj__.class
  end

  def attributes=(attributes)
    attributes = AttributesWithContent.new(attributes)
    if attributes.content
      self.content.content = attributes.content
    end
    super(attributes.to_h)
  end

  class AttributesWithContent
    pattr_initialize :attributes
    def to_h
      attributes.except(:content)
    end

    def content
      attributes[:content]
    end
  end
end
