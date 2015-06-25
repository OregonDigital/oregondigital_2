module OregonDigital
  def inject
    @injector ||= OregonDigital::Injector.new
  end

  def derivative_injector
    @derivative_injector ||= OregonDigital::DerivativeInjector.new
  end

  def marmotta
    @marmotta ||= Marmotta::Connection.new(uri: config.marmotta.url, context: Rails.env)
  end

  def iiif_server_url
    @iiif_server ||= config.openseadragon.iiif_server
  end

  def config
    ODSettings
  end
  module_function :inject
  module_function :derivative_injector
  module_function :marmotta
  module_function :iiif_server_url
  module_function :config
end
