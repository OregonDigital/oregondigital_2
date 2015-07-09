class Admin::FacetsController < AdminController
  def index
    @facets = FacetConfigurationFacade.new
  end

  def create
    if FacetField.create(facet_field_params)
      flash[:success] = t('admin.facets.field_created')
      redirect_to admin_facets_path
    end
  end

  def destroy
    begin
      if find_facet(params[:id]).destroy
        flash[:success] = t('admin.facets.destroy.success')
      end
    rescue
      flash[:alert] = t('admin.facets.destroy.fail')
    end
    redirect_to admin_facets_path
  end

  private

  def find_facet(id)
    FacetField.find(id)
  end

  def facet_field_params
    params.require(:facet_field).permit(:key)
  end

end
