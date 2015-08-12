class RecordsController < ApplicationController
  include RecordsControllerBehavior

  def ingest_options
    @templates = [["Raw (no template)", nil]] + template_class.all.collect {|t| [t.title, t.id]}
  end

  protected

  def build_form
    f = super
    f.template = template_class.find_by_id(params[:template_id])
    f
  end

  def template_class
    FormTemplate
  end

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
end
