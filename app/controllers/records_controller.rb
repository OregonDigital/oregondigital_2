class RecordsController < ApplicationController
  include RecordsControllerBehavior

  protected

  def set_attributes
    resource.attributes = AttributeURIConverter.new(collect_form_attributes).convert_attributes
  end

  def resource
    decorate(super)
  end

  def decorate(resource)
    derivative_asset = AssetWithDerivativesFactory.new(HasContent.new(resource))
    ValidatedAssetRepository.new(resource.class).decorate(derivative_asset)
  end

end
