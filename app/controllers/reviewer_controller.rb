
class ReviewerController < CatalogController
  before_action :enforce_reviewer
  self.search_params_logic += [:only_unreviewed]
  self.search_params_logic -= [:add_access_controls_to_solr_params]

  def review
    reviewer_asset.review!
    flash[:notice] = "Successfully reviewed."
    redirect_to reviewer_index_path
  end

  private

  def reviewer_asset
    decorator.new(GenericAsset.find(params[:id]))
  end

  def decorator
    DecoratorList.new(
      Reviewable,
      ReviewingAsset
    )
  end

  def enforce_reviewer
    unless can?(:review, GenericAsset)
      raise Hydra::AccessDenied.new("You do not have sufficient access privileges to access this.")
    end
  end

  def config_builder
    @set_config ||= super.tap do |t|
      t.reviewing = true
    end
  end
end
