class Admin::FormTemplatesController < ApplicationController
  before_action :enforce_admin

  def index
    @templates = template_class.all
  end

  def new
    @template = template_class.new
    @template.property_names = terms
  end

  def create
    @template = template_class.new(form_template_params)
    if @template.save
      flash[:success] = t('admin.form_templates.create.success')
      redirect_to admin_form_templates_path
    else
      flash[:alert] = t('admin.form_templates.create.fail')
      render :new
    end
  end

  def edit
    @template = find_template
    @template.property_names = terms
  end

  def update
    @template = find_template
    if @template.update_attributes(form_template_params)
      flash[:success] = t('admin.form_templates.update.success')
      redirect_to admin_form_templates_path
    else
      flash[:alert] = t('admin.form_templates.update.fail')
      render :edit
    end
  end

  def destroy
    if find_template.destroy
      flash[:success] = t('admin.form_templates.destroy.success')
    else
      flash[:alert] = t('admin.form_templates.destroy.fail')
    end

    redirect_to admin_form_templates_path
  end

  private

  def enforce_admin
    unless can?(:manage, FormTemplate)
      raise Hydra::AccessDenied.new("You do not have sufficient access privileges to access this.")
    end
  end

  def find_template
    template_class.find(params[:id])
  end

  def form_template_params
    params.require(:form_template).permit(:title, {:properties_attributes => [:id, :name, :visible, :required]})
  end

  def template_class
    FormTemplate
  end

  def terms
    GenericAssetForm.terms
  end
end
