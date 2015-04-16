class BlacklightConfig
  attr_reader :metadata_class, :default_configuration
  def initialize(metadata_class, default_configuration)
    @metadata_class = metadata_class
    @default_configuration = default_configuration
    apply_configurations
  end

  def configuration
    @configuration ||= default_configuration.deep_copy
  end

  private

  def configurations
    [
      ShowConfiguration.new(configuration, metadata_class),
      ViewConfiguration.new(configuration),
      DefaultConfiguration.new(configuration)
    ]
  end

  def apply_configurations
    configurations.each(&:run)
  end

end
