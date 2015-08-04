class ReviewerController < CatalogController
  before_action :enforce_reviewer
  self.search_params_logic += [:only_unreviewed]
  self.search_params_logic -= [:add_access_controls_to_solr_params]

  private

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
