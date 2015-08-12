class ReviewingAsset < SimpleDelegator
  def review!
    self.public = true
    self.reviewed = true
    save
  end

  def class
    __getobj__.class
  end
end
