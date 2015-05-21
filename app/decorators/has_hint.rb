class HasHint < SimpleDelegator
  def options
    super.merge({:hint => hint})
  end

  def hint
    nil
  end
end
