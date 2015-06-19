require 'vips'
class DerivativeIIIFResolver
  def find(id)
    Riiif::File.new(path(id))
  end

  def path(id)
    OregonDigital.derivative_injector.pyramidal_path(id)
  end
end
Riiif::Image.file_resolver = DerivativeIIIFResolver.new
Riiif::Image.info_service = lambda do |id, file|
  img = VIPS::Image.new(file.path.to_s)
  { :height => img.y_size, :width => img.x_size }
end

Riiif::Engine.config.cache_duration_in_days = 30
