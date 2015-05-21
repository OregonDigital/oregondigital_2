##
# ActiveFedora needs information about how to solrize each field as well as
# which class to spin up each property as. This is information independent of
# the Data Model, so this class decorates #properties with that additional
# information.
class DecoratedODDataModel
  class << self
    def properties
      @properties ||= DecoratedCollection.new(ODDataModel.properties, decorators)
    end

    # Composite of decorators to apply to the data model.
    def decorators
      DecoratorList.new(
        DecoratorWithArguments.new(DefaultClass, TriplePoweredResource),
        DecoratorWithArguments.new(ClassConfiguration, config_map)
      )
    end

    # Map of which classes to apply to which property.
    # @example
    #   {:title => "GenericAsset"}
    def config_map
      {
      }
    end
  end
end
