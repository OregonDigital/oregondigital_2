class AssetWithDerivatives < SimpleDelegator
  attr_reader :derivative_class

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
    content.content_changed? && !content.content.blank?
  end

  private

  def runners
    @runners ||= OregonDigital::Derivatives::Runners::RunnerFinder.find(__getobj__)
  end

  def derivative_callback
    @derivative_callback ||= OregonDigital::Derivatives::DerivativeCallback.new(self)
  end

  def stream_content
    @stream_content ||= StreamableContent.new(content.content, content.mime_type)
  end

end
