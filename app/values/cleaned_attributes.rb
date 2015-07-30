class CleanedAttributes
  def self.from(base)
    new(base).result
  end

  pattr_initialize :base

  def result
    base.merge(converted)
  end

  private

  def converted
    @converted ||= AttributeURIConverter.new(truncated_base).convert_attributes
  end

  def truncated_base
    base.except(*string_properties)
  end

  def string_properties
    @string_properties ||= ODDataModel.properties.select{|x| x.cast == false}
      .map(&:name)
      .map(&:to_s)
  end
end
