class RecordsController < ApplicationController
  include RecordsControllerBehavior

  def ingest_options
    @templates = [["Raw (no template)", nil]] + FormTemplate.all.collect {|t| [t.title, t.id]}
  end

  def new
    @form = build_form
    find_template
    render 'records/new'
  end

  def edit
    @form = build_form
    find_template
    render 'records/edit'
  end

  protected

  def collect_form_attributes
    CleanedAttributes.from(super)
  end

  def resource
    decorate(super)
  end

  def decorate(resource)
    derivative_asset = resource_decorators.new(resource)
    ValidatedAssetRepository.new(resource.class).decorate(derivative_asset)
  end

  def resource_decorators
    DecoratorList.new(
      AssetWithDerivativesFactory,
      HasContent,
      EnrichesSolr
    )
  end

  def find_template
    template_id = params[:template_id].to_i
    if template_id > 0
      @form.template = FormTemplate.find(template_id)
    end
  end
end
