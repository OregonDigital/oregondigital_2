class DerivativePath < SimpleDelegator
  delegate :to_s, :to => :__getobj__

  def initialize(string_or_path)
    super(Pathname.new(string_or_path.to_s))
  end

  def relative_path
    Pathname.new("/").join(relative_path_from(derivative_base))
  end

  def derivative_base
    injector.derivative_base.parent
  end

  def derivative_type
    relative_path_from(injector.derivative_base).to_s.split("/").first.singularize.to_sym
  end

  private

  def injector
    @inkjector ||= OregonDigital.derivative_injector
  end
end
