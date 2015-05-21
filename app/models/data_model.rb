class DataModel
  ##
  # Super class which provides a simple property DSL for defining property ->
  # predicate mappings.
  class << self
    # @param [Symbol] property The property name on the object.
    # @param [Hash] options Options for the property.
    # @option options [RDF::URI] :predicate The predicate to map the property
    #   to.
    def property(property, options)
      properties << Property.new(options.merge(:name => property))
    end

    def properties
      @properties ||= []
    end

    # @return [Hash{Symbol => RDF::URI}] Returns a hash of property names and
    #   their configured predicates.
    def simple_properties
      @simple_properties ||= Hash[properties.group_by(&:name).map{|k, v| [k,v.first.predicate]}]
    end
  end

  def properties
    self.class.properties
  end

  def simple_properties
    self.class.simple_properties
  end
end
