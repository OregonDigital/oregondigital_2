class ReviewingAsset < SimpleDelegator
  def save
    self.public = true
    self.reviewed = true
    super
  end

  def class
    __getobj__.class
  end
end
