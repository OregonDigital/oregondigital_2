class AssetWithDerivatives < SimpleDelegator
  attr_reader :derivative_class, :runners

  def initialize(asset, runners)
    super(asset)
    @runners = runners
  end

  def save
    check_derivatives
    result = __getobj__.save
    create_derivatives if needs_derivatives?
    result
  end

  private

  def check_derivatives
    if content_changed?
      @needs_derivatives = true
    end
  end

  def create_derivatives
    @needs_derivatives = false
    begin
      runners.run(stream_content, self)
    rescue NotImplementedError
    end
  end

  def needs_derivatives?
    @needs_derivatives
  end

  def content_changed?
    content.content_changed? && !content.content.blank?
  end

  private

  def stream_content
    @stream_content ||= StringIO.new(content.content)
  end

end
