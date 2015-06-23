class CapistranoAwarePath < SimpleDelegator
  def initialize(path_or_string)
    super(clean(path_or_string))
  end

  private

  def clean(path)
    path = path.to_s.gsub(/releases\/.*?\//, 'release_path/')
    Pathname.new(path.gsub(/releases\/[^\/]*$/, 'release_path'))
  end
end
