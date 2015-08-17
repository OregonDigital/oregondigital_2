class Ability
  include Hydra::Ability
  
  # Define any customized permissions here.
  def custom_permissions
    if current_user.admin?
      can :manage, :all
    end
  end

  def user_groups
    super + ip_groups
  end

  def ip_groups
    @ip_groups ||= IpBasedGroup.for_ip(current_user.current_sign_in_ip)
  end
end
