class BlacklightConfig
  attr_reader :metadata_class, :default_configuration, :set
  def initialize(metadata_class, default_configuration)
    @metadata_class = metadata_class
    @default_configuration = default_configuration
    apply_configurations
  end

  def set=(set)
    @set = set
    ApplySet.new(configuration, set).run
  end

  def reviewing=(reviewing)
    if reviewing
      configuration.show.route = { :controller => "reviewer" }
    end
  end

  def configuration
    @configuration ||= default_configuration.deep_copy
  end

  private

  def configurations
    [
      ShowConfiguration.new(configuration, metadata_class),
      ViewConfiguration.new(configuration),
      DefaultConfiguration.new(configuration),
      SearchFieldConfiguration.new(configuration),
      ShowActions.new(configuration),
      ThumbnailConfiguration.new(configuration),
      IndexConfiguration.new(configuration),
      FacetFields.new(configuration),
    ] | plugins
  end

  def plugins
    [
      Gallery.new(configuration),
      Embed.new(configuration)
    ]
  end

  def apply_configurations
    configurations.each(&:run)
  end

end
