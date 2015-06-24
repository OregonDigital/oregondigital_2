class BlacklightConfig::Gallery
  pattr_initialize :configuration

  def run
    configuration.view.gallery.partials = [:index_header, :index]
    configuration.view.masonry.partials = [:index]
    configuration.view.slideshow.partials = [:index]
  end
end
