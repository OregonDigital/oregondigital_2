module OregonDigital
  def inject
    @injector ||= OregonDigital::Injector.new
  end

  def derivative_injector
    @derivative_injector ||= OregonDigital::DerivativeInjector.new
  end
  module_function :inject
  module_function :derivative_injector
end
