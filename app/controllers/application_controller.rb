class ApplicationController < ActionController::Base
  helper Openseadragon::OpenseadragonHelper
  rescue_from CanCan::AccessDenied, :with => :unauthorized

  before_filter do
    resource = controller_path.singularize.gsub('/', '_').to_sym 
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end
  # Adds a few additional behaviors into the application controller 
  include Blacklight::Controller
  # Please be sure to impelement current_user and user_session. Blacklight depends on 
  # these methods in order to perform user specific actions. 

  layout 'blacklight'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_ability
    @current_ability ||= ::Ability.new(current_user, request.remote_ip)
  end

  private

  def unauthorized
    flash[:error] = "You do not have sufficient permissions to view this page"
    redirect_to root_path
  end
end
