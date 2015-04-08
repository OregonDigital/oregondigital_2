class BlacklightConfig
  attr_reader :metadata_class, :default_configuration
  def initialize(metadata_class, default_configuration)
    @metadata_class = metadata_class
    @default_configuration = default_configuration
    apply_show_fields
  end

  def configuration
    @configuration ||= default_configuration.deep_copy
  end

  private

  def apply_show_fields
    show_fields.each do |field|
      configuration.add_show_field field.key, :label => field.label
    end
  end

  def show_fields
    metadata_class.properties.keys.map{|x| ShowField.new(x) }
  end
end
