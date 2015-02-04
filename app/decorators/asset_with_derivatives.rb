class AssetWithDerivatives < SimpleDelegator

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
      derivative_creator.run
    rescue NotImplementedError
    end
  end

  def derivative_creator
    derivative_class.new(self, content, *runners)
  end

  def runners
    [
    ]
  end

  def derivative_class
    raise NotImplementedError
  end

  def needs_derivatives?
    @needs_derivatives
  end

  def content_changed?
    content.content_changed? && !content.content.blank?
  end
end
