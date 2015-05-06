class ApplyProperties
  pattr_initialize :properties
  
  def apply!(asset)
    properties.each do |property_name, config|
      asset.property property_name, config_to_configuration(config)
    end
  end

  private

  def config_to_configuration(config)
    {
      :predicate => config.predicate,
      :class_name => config.class_name
    }
  end
end
