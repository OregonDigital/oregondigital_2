class DocumentWithDerivatives < SimpleDelegator
  delegate :derivative_decorator_class, :runner_list, :to => :derivative_injector

  def save
    derivative_asset.save
  end

  def pdf_success(path)
    self.has_pdf_pages = true
    self.pdf_pages_path = path
  end

  def derivative_injector
    OregonDigital.derivative_injector
  end

  private

  def derivative_asset
    @derivative_asset ||= derivative_decorator_class.new(__getobj__, runners)
  end

  def runners
    @runners ||= runner_list.new(
      [
        derivative_injector.pdf_runner(id)
      ]
    )
  end

end
