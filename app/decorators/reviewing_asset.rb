class ReviewingAsset < SimpleDelegator
  def review!
    self.public = true
    self.reviewed = true
    save
  end

  def unreview!
    self.reviewed = false
    save
  end

  def class
    __getobj__.class
  end
end
