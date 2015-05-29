class RecordsController < ApplicationController
  include RecordsControllerBehavior

  protected

  def collect_form_attributes
    AttributeURIConverter.new(super).convert_attributes
  end

  def resource
    decorate(super)
  end

  def decorate(resource)
    derivative_asset = AssetWithDerivativesFactory.new(HasContent.new(resource))
    ValidatedAssetRepository.new(resource.class).decorate(derivative_asset)
  end

end
