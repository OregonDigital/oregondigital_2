class Property < OpenStruct
  def to_h
    super.except(:name)
  end
end
