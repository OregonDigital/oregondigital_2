class AdminController < ApplicationController
  before_filter :authenticate

  def index
  end

  private

  def authenticate
    unless current_user && current_user.admin?
      raise CanCan::AccessDenied
    end
  end
end
