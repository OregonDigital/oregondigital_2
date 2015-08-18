class Admin::IpBasedGroupsController < ApplicationController
  before_action :enforce_admin

  def index
    @ip_based_groups = IpBasedGroup.all
  end

  def new
    @ip_based_group = IpBasedGroup.new
    @roles = all_roles
  end

  def create
    @ip_based_group = IpBasedGroup.new(ip_based_group_params)
    if @ip_based_group.save
      redirect_to admin_ip_based_groups_path
    else
      @roles = all_roles
      render :new
    end
  end

  def edit
    @ip_based_group = find_group
    @roles = all_roles
  end

  def update
    @ip_based_group = find_group
    if @ip_based_group.update_attributes(ip_based_group_params)
      redirect_to admin_ip_based_groups_path
    else
      @roles = all_roles
      render :edit
    end
  end

  private

  def all_roles
    Role.all
  end

  def enforce_admin
    unless can?(:manage, IpBasedGroup)
      raise Hydra::AccessDenied.new("You do not have sufficient access privileges to access this.")
    end
  end

  def find_group
    IpBasedGroup.find(params[:id])
  end

  def ip_based_group_params
    params.require(:ip_based_group).permit(:title, :ip_start, :ip_end, :role_id)
  end
end
