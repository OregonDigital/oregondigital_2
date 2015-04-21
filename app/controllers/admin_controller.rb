class AdminController < ApplicationController

  def index
    unless current_user_is_admin?
      flash[:error] = "You do not have sufficient permissions to view this page"
      redirect_to root_path
    end
  end

  private

  def current_user_is_admin?
    if current_user and can? :create, GenericAsset
      true
    else
      false
    end
    false
  end
end
