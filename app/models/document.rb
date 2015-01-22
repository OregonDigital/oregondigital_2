class Document < GenericAsset
  has_derivatives :pdf_pages

  private

  def derivative_creator
    derivative_class.new(self, content, injector.pdf_runner(id))
  end

  def derivative_class
    OregonDigital::Derivatives::Generators::DocumentDerivativeGenerator
  end
end
