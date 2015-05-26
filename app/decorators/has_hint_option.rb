class HasHintOption < SimpleDelegator
  def options
    super.merge({:hint => hint})
  end

  def hint
    object.model.validators[property].map(&:message)[0] unless object.model.validators[property].nil?
  end
end
