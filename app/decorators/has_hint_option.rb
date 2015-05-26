class HasHintOption < SimpleDelegator
  def options
    super.merge({:hint => hint})
  end

  def hint
    "Must fulfill: #{hint_message}" if hint_message
  end

  private

  def hint_message
    Array(object.validators[property]).map(&:message)[0]
  end
end
