class AdminController < ApplicationController
  before_filter :authenticate

  def index
  end

  private

  def authenticate
    unless can? :manage, :all
      raise CanCan::AccessDenied
    end
  end
end
