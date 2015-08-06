class RecordsController < ApplicationController
  include RecordsControllerBehavior

  def update
    super
    if params[:to_review] == "1"
      unreview_asset
    end
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

  def unreview_asset
    reviewable_asset.unreview!
  end

  def reviewing_decorators
    DecoratorList.new(
      Reviewable,
      ReviewingAsset
    ) 
  end

  def reviewable_asset
    reviewing_decorators.new(GenericAsset.find(params[:id]))
  end

end
