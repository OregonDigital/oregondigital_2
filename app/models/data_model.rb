class DataModel
  class << self
    def property(property, options)
      properties << Property.new(options.merge(:name => property))
    end

    def properties
      @properties ||= []
    end
  end

  def properties
    self.class.properties
  end
end
