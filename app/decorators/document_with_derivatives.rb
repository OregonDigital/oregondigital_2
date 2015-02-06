class DocumentWithDerivatives < SimpleDelegator
  def save
    derivative_asset.save
  end

  def pdf_success(path)
    self.has_pdf_pages = true
    self.pdf_pages_path = path
  end

  private

  def derivative_asset
    @derivative_asset ||= AssetWithDerivatives.new(__getobj__, runners)
  end


  def runners
    @runners ||= OregonDigital::Derivatives::Runners::RunnerList.new(
      [
        injector.pdf_runner(id)
      ]
    )
  end

end
