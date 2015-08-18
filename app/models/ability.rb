class Ability
  include Hydra::Ability

  attr_accessor :remote_ip

  def initialize(user, remote_ip = nil)
    @remote_ip = remote_ip
    super(user)
  end
  
  # Define any customized permissions here.
  def custom_permissions
    if user_groups.include?("admin")
      can :manage, :all
    end
  end

  def user_groups
    super + ip_groups
  end

  def ip_groups
    @ip_groups ||= IpBasedGroup.for_ip(remote_ip)
  end
end
