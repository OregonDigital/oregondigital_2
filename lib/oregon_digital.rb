module OregonDigital
  def inject
    @injector ||= OregonDigital::Injector.new
  end
  module_function :inject
end
