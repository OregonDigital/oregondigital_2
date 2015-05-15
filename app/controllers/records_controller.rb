class RecordsController < ApplicationController
  include RecordsControllerBehavior

  private

  def resource
    decorate(super)
  end

  def decorate(resource)
    AssetWithDerivativesFactory.new(HasContent.new(resource))
  end

end
