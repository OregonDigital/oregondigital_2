class Admin::FormTemplatesController < ApplicationController
  before_action :enforce_admin

  def index
    @templates = template_class.all
  end

  def new
    @template = template_class.new
    terms.each {|term| @template.properties.build(:name => term)}
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
    params.require(:form_template).permit(:title, {:properties_attributes => [:id, :name, :visible]})
  end

  def template_class
    FormTemplate
  end

  def terms
    GenericAssetForm.terms
  end
end
