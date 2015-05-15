class AssetWithDerivatives < SimpleDelegator
  attr_reader :runner
  def initialize(asset, runner)
    super(asset)
    @runner = runner
  end

  def class
    __getobj__.class
  end

  def save
    check_derivatives
    result = __getobj__.save
    create_derivatives if needs_derivatives? && result
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
    runner.run(self)
  end

  def needs_derivatives?
    @needs_derivatives
  end

  def content_changed?
    content_content_changed? && !content_blank?
  end

end
