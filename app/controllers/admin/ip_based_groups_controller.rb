class Admin::IpBasedGroupsController < ApplicationController
  before_action :enforce_admin

  def index
    @ip_based_groups = groups_factory.all
  end

  def new
    @ip_based_group = groups_factory.new
    @roles = all_roles
  end

  def create
    @ip_based_group = groups_factory.new(ip_based_group_params)
    if @ip_based_group.save
      flash[:success] = t('admin.ip_based_groups.create.success')
      redirect_to admin_ip_based_groups_path
    else
      flash[:alert] = t('admin.ip_based_groups.create.fail')
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
      flash[:success] = t('admin.ip_based_groups.update.success')
      redirect_to admin_ip_based_groups_path
    else
      flash[:alert] = t('admin.ip_based_groups.update.fail')
      @roles = all_roles
      render :edit
    end
  end

  def destroy
    if find_group.destroy
      flash[:success] = t('admin.ip_based_groups.destroy.success')
    else
      flash[:alert] = t('admin.ip_based_groups.destroy.fail')
    end

    redirect_to admin_ip_based_groups_path
  end

  private

  def all_roles
    Role.all
  end

  def groups_factory
    IpBasedGroup
  end

  def groups_param_key
    groups_factory.model_name.param_key
  end

  def enforce_admin
    unless can?(:manage, IpBasedGroup)
      raise Hydra::AccessDenied.new("You do not have sufficient access privileges to access this.")
    end
  end

  def find_group
    groups_factory.find(params[:id])
  end

  def ip_based_group_params
    params.require(groups_param_key).permit(:title, :ip_start, :ip_end, :role_id)
  end
end
