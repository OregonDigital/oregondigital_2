class RecordsController < ApplicationController
  include RecordsControllerBehavior

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


end
