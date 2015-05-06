class ApplyProperties
  pattr_initialize :properties, :application_strategy
  
  def apply!(asset)
    properties.each do |property|
      application_strategy.call(asset, property)
    end
  end
end
