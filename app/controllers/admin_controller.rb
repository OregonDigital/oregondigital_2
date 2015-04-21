class AdminController < ApplicationController

  def index
    unless current_user_is_admin?
      flash[:error] = "You do not have sufficient permissions to view this page"
      redirect_to root_path
    end
  end

  private

  def current_user_is_admin?
    can?(:create, GenericAsset)
  end
end
