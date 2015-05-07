class Ability
  include Hydra::Ability
  
  # Define any customized permissions here.
  def custom_permissions
    if current_user.admin?
      can :manage, :all
    end
  end
end
