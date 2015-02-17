class AssetWithDerivatives < SimpleDelegator
  attr_reader :derivative_callback, :stream_content, :runners
  def initialize(asset, runners, derivative_callback, stream_content)
    super(asset)
    @runners = runners
    @derivative_callback = derivative_callback
    @stream_content = stream_content
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
      runners.run(stream_content, derivative_callback)
    rescue NotImplementedError
    end
  end

  def needs_derivatives?
    @needs_derivatives
  end

  def content_changed?
    content_content_changed?
  end

end
