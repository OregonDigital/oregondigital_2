# Encapsulates applying properties given a strategy.
class ApplyProperties
  pattr_initialize :properties, :application_strategy
  
  # @param [ActiveFedora::Base] asset The asset to apply a property to.
  def apply!(asset)
    properties.each do |property|
      application_strategy.call(asset, property)
    end
  end
end
