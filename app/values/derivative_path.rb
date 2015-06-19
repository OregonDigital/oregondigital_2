class DerivativePath < SimpleDelegator
  delegate :to_s, :to => :__getobj__
  delegate :derivative_base, :to => :injector

  def relative_path
    Pathname.new("/").join(relative_path_from(derivative_base))
  end

  def derivative_base
    injector.derivative_base.parent
  end

  private

  def injector
    @inkjector ||= OregonDigital.derivative_injector
  end
end
