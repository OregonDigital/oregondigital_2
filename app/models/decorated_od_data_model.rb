class DecoratedODDataModel
  def self.properties
    @properties ||= DecoratedCollection.new(ODDataModel.properties, decorators)
  end

  def self.decorators
    DecoratorWithArguments.new(DefaultClass, TriplePoweredResource)
  end

end
