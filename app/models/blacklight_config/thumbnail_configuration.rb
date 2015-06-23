class BlacklightConfig::ThumbnailConfiguration
  pattr_initialize :configuration
  def run
    configuration.index.thumbnail_field = :workflow_metadata__thumbnail_path_ssim
  end
end
