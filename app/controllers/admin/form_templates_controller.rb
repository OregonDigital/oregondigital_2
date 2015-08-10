class Admin::FormTemplatesController < ApplicationController
  before_action :enforce_admin

  def index
    @templates = template_class.all
  end

  private

  def enforce_admin
    unless can?(:manage, FormTemplate)
      raise Hydra::AccessDenied.new("You do not have sufficient access privileges to access this.")
    end
  end

  def template_class
    FormTemplate
  end
end
