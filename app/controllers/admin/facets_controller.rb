class Admin::FacetsController < AdminController
  def index
    @facets = FacetConfigurationFacade.new
    @facet = FacetField.new
  end

  def create
    if FacetField.create(facet_field_params)
      flash[:success] = "Facet field created"
      redirect_to admin_facets_path
    else
      flash[:error] = "Failed to create facet"
      redirect_to admin_facets_path
    end
  end

  private

  def facet_field_params
    params.require(:facet_field).permit(:key)
  end

end
