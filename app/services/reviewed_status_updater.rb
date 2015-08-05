class ReviewedStatusUpdater
  def initialize(id, to_review)
    @id = id
    @to_review = to_review
  end
  
  def update_review_status!
    update_asset if @to_review == "1"
  end 
 
  private

  def update_asset
    asset.workflow_metadata.reviewed = false
    @asset.save
  end

  def asset
    @asset ||= GenericAsset.find(@id)
  end
end
