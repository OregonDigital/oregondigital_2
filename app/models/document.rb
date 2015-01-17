class Document < GenericAsset
  [:pdf_pages].each do |derivative|
    delegate :"has_#{derivative}", :"has_#{derivative}=", :to => :workflow_metadata, :allow_nil => true
    delegate :"#{derivative}_path", :"#{derivative}_path=", :to => :workflow_metadata, :allow_nil => true
  end

  private

  def derivative_creator
    derivative_class.new(self, content, injector.pdf_runner(id))
  end

  def derivative_class
    OregonDigital::Derivatives::Generators::DocumentDerivativeGenerator
  end

  def injector
    @injector ||= OregonDigital.inject
  end
end
