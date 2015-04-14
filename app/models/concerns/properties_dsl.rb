module PropertiesDSL
  extend ActiveSupport::Concern
  def properties
    self.class.properties
  end
  module ClassMethods
    def property(property, options)
      predicate = options.fetch(:predicate)
      properties[property] = ActiveFedora::Attributes::NodeConfig.new(property, predicate, options.except(:predicate))
    end
    def properties
      @properties ||= {}
    end
  end
end
