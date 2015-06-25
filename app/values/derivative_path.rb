class DerivativePath < SimpleDelegator
  delegate :to_s, :to => :__getobj__
  attr_reader :path_factory

  def initialize(string_or_path, path_factory=CapistranoAwarePath)
    @path_factory = path_factory
    super(path_factory.new(string_or_path))
  end

  def present?
    true
  end

  def relative_path
    path_factory.new("/").join(relative_path_from(derivative_base))
  end

  def derivative_type
    relative_path_from(path_factory.new(injector.derivative_base)).to_s.split("/").first.singularize.underscore.to_sym
  end

  def to_iiif
    path_factory.new(OregonDigital.iiif_server_url).join(escape_slashes(relative_path_no_slash), "info.json")
  end

  private

  def relative_path_no_slash
    relative_path.to_s.sub(%r|^\/|, '')
  end

  def derivative_base
    path_factory.new(injector.derivative_base.parent)
  end

  def escape_slashes(s)
    s.gsub("/", "%2F")
  end

  private

  def injector
    @inkjector ||= OregonDigital.derivative_injector
  end
end
