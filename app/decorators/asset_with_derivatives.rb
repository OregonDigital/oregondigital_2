class AssetWithDerivatives < SimpleDelegator
  attr_reader :derivative_callback, :runner_finder
  def initialize(asset, runner_finder, derivative_callback)
    super(asset)
    @runner_finder = runner_finder
    @derivative_callback = derivative_callback
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
      runners.run(streamable_content, derivative_callback)
    rescue NotImplementedError
    end
  end

  def needs_derivatives?
    @needs_derivatives
  end

  def content_changed?
    content_content_changed?
  end

  private

  def runners
    @runners ||= runner_finder.find(__getobj__)
  end

end
