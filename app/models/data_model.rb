class DataModel
  class << self
    def property(property, options)
      properties << Property.new(options.merge(:name => property))
    end

    def properties
      @properties ||= []
    end

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
