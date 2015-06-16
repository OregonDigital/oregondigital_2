class SetsController < CatalogController
  rescue_from ActiveFedora::ObjectNotFoundError, :with => :set_not_found
  self.search_params_logic += [:restrict_to_set]

  def index
    @set = find_set(params[:set_id])
    super
  end

  # Overrides search_builder to allow for restricting to given set.
  def search_builder(*args)
    super.tap do |builder|
      if @set
        builder.set = @set
      end
    end
  end

  private

  def find_set(set_id)
    GenericSet.load_instance_from_solr(set_id)
  end

  def config_builder
    @set_config ||= super.tap do |t|
      t.set = find_set(params[:set_id])
    end
  end

  def set_not_found
    flash[:error] = t("sets.set_not_found")
    redirect_to root_path
  end
end
