class DocumentWithDerivatives < SimpleDelegator
  def save
    derivative_asset.save
  end

  private

  def derivative_asset
    @derivative_asset ||= AssetWithDerivatives.new(__getobj__, derivative_class, runners)
  end


  def runners
    [
      injector.pdf_runner(id)
    ]
  end

  def derivative_class
    OregonDigital::Derivatives::Generators::DocumentDerivativeGenerator
  end
end
