class DerivativePath < SimpleDelegator
  delegate :to_s, :to => :__getobj__

  def initialize(string_or_path)
    super(clean(string_or_path))
  end

  def relative_path
    Pathname.new("/").join(relative_path_from(derivative_base))
  end

  def derivative_base
    clean(injector.derivative_base.parent)
  end

  def derivative_type
    relative_path_from(clean(injector.derivative_base)).to_s.split("/").first.singularize.underscore.to_sym
  end

  private

  def clean(path)
    p = Pathname.new(path.to_s.gsub(/releases\/.*?\//, 'release_path/'))
    p = Pathname.new(p.to_s.gsub(/releases\/[^\/]*$/, 'release_path'))
  end

  def injector
    @inkjector ||= OregonDigital.derivative_injector
  end
end
