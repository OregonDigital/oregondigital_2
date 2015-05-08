class DecoratedODDataModel
  class << self
    def properties
      @properties ||= DecoratedCollection.new(ODDataModel.properties, decorators)
    end

    def decorators
      DecoratorList.new(
        DecoratorWithArguments.new(DefaultClass, TriplePoweredResource),
        DecoratorWithArguments.new(ClassConfiguration, config_map)
      )
    end

    def config_map
      {
      }
    end
  end
end
