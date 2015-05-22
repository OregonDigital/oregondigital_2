module OregonDigital
  def inject
    @injector ||= OregonDigital::Injector.new
  end

  def derivative_injector
    @derivative_injector ||= OregonDigital::DerivativeInjector.new
  end

  def marmotta
    @marmotta ||= MarmottaConnection.new(uri: config.marmotta.url, context: Rails.env)
  end

  def config
    ODSettings
  end
  module_function :inject
  module_function :derivative_injector
  module_function :marmotta
  module_function :config
end
