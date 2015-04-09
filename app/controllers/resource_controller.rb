class ResourceController < ApplicationController
  def show
    raise ActionController::RoutingError.new 'resource not found'
  end
end 
