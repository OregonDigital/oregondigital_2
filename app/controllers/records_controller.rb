class RecordsController < ApplicationController
  include RecordsControllerBehavior

  def ingest_options
    authorize! :new, GenericAsset
    @templates = [["Raw (no template)", nil]] + template_select_options
  end

  protected

  def build_form
    super.tap do |f|
      f.template = template_class.find_by_id(params[:template_id])
    end
  end

  def template_select_options
    template_class.pluck(:title, :id)
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
      EnrichesSolr,
      Reviewable
    )
  end

end
