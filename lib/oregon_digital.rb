module OregonDigital
  def inject
    @injector ||= OregonDigital::Injector.new
  end

  def derivative_injector
    @derivative_injector ||= OregonDigital::DerivativeInjector.new
  end

  def marmotta
    @marmotta ||= MarmottaConnection.new(uri: "http://localhost:8983/marmotta", context: Rails.env)
  end
  module_function :inject
  module_function :derivative_injector
  module_function :marmotta
end
