class RecordsController < ApplicationController
  include RecordsControllerBehavior

  private

  def resource
    decorate(super)
  end

  def decorate(resource)
    derivative_asset = AssetWithDerivativesFactory.new(HasContent.new(resource))
    ValidatedAssetRepository.new(resource.class).decorate(derivative_asset)
  end

end
