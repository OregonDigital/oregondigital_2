class SetsController < CatalogController
  rescue_from ActiveFedora::ObjectNotFoundError, :with => :set_not_found
  self.search_params_logic += [:restrict_to_set]

  def index
    if params[:set_id]
      @set = find_set(params[:set_id])
    else
      @sets = find_all_sets
      render "sets/all_sets.html.erb"
    end
    super
  end

  def all_sets
    @sets = find_all_sets
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

  def find_all_sets
    GenericSet.all 
  end

  def find_set(set_id)
    GenericSet.load_instance_from_solr(set_id)
  end

  def config_builder
    if params[:set_id]
      @set_config ||= super.tap do |t|
        t.set = find_set(params[:set_id])
      end
    else
      @set_config ||= super
    end
  end

  def set_not_found
    flash[:error] = t("sets.set_not_found")
    redirect_to root_path
  end
end
