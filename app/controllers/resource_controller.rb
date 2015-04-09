class ResourceController < ApplicationController
  def show
    if ActiveFedora::Base.exists?(params[:id])
      redirect_to catalog_path(:id => params[:id])
    else
      raise ActionController::RoutingError.new 'resource not found'
    end
  end
end 
