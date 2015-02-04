class DocumentWithDerivatives < AssetWithDerivatives
  def runners
    [
      injector.pdf_runner(id)
    ]
  end

  def derivative_class
    OregonDigital::Derivatives::Generators::DocumentDerivativeGenerator
  end
end
