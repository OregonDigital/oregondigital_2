class ApplyProperties
  pattr_initialize :properties
  
  def apply!(asset)
    properties.each do |property_name, config|
      asset.property property_name, config_to_configuration(config) do |index|
        index.as(*index_types)
      end
    end
  end

  def index_types
    [:searchable, :displayable, :facetable]
  end

  private

  def config_to_configuration(config)
    {
      :predicate => config.predicate,
      :class_name => config.class_name
    }
  end
end
