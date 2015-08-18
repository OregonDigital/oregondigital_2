class Admin::IpBasedGroupsController < ApplicationController
  def index
    @ip_based_groups = IpBasedGroup.all
  end

  def new
    @ip_based_group = IpBasedGroup.new
    @roles = Role.all
  end

  def create
    @ip_based_group = IpBasedGroup.new(ip_based_group_params)
    if @ip_based_group.save
      redirect_to admin_ip_based_groups_path
    else
      @roles = Role.all
      render :new
    end
  end

  def edit
    @ip_based_group = find_group
    @roles = Role.all
  end

  def update
    @ip_based_group = find_group
    if @ip_based_group.update_attributes(ip_based_group_params)
      redirect_to admin_ip_based_groups_path
    else
      @roles = Role.all
      render :edit
    end
  end

  private

  def find_group
    IpBasedGroup.find(params[:id])
  end

  def ip_based_group_params
    params.require(:ip_based_group).permit(:title, :ip_start, :ip_end, :role_id)
  end
end
