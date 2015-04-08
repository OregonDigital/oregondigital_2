class BlacklightConfig
  attr_reader :metadata_class
  def initialize(metadata_class)
    @metadata_class = metadata_class
    apply_show_fields
  end

  def default_configuration
    CatalogController.blacklight_config.deep_copy
  end

  def configuration
    @configuration ||= default_configuration
  end

  private

  def apply_show_fields
    show_fields.each do |field|
      configuration.add_show_field field.key, :label => field.label
    end
  end

  def show_fields
    GenericAsset.properties.keys.map{|x| ShowField.new(x) }
  end
end
