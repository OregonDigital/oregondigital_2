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

  def update
    facet = find_facet(params[:id])
    respond_to do |format|
      if facet.update(facet_field_params)
        format.html { redirect_to admin_facets_path }
        format.json { respond_with_bip(facet) }
      else
        flash[:alert] = t('admin.facets.update.fail')
        format.html { redirect_to admin_facets_path }
        format.json { respond_with_bip(facet) }
      end
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

  def remove_item
    begin
      set_visibility
      flash[:success] = t('admin.facets.remove_item.success')
    rescue
      flash[:alert] = t('admin.facets.remove_item.fail')
    end
    redirect_to admin_facets_path

  end

  def add_item
    begin
      set_visibility
      flash[:success] = t('admin.facets.add_item.success')
    rescue
      flash[:alert] = t('admin.facets.add_item.fail')
    end
    redirect_to admin_facets_path

  end

  private

  def set_visibility
    facet_item = find_item(params[:id])
    if facet_item.visible
      facet_item.visible = false
    else
      facet_item.visible = true
    end
    facet_item.save
  end

  def find_item(id)
    FacetItem.find(id)
  end

  def find_facet(id)
    FacetField.find(id)
  end

  def facet_item_params
    params.require(:facet_item).permit(:value)
  end

  def facet_field_params
    params.require(:facet_field).permit(:key, :label)
  end

end
