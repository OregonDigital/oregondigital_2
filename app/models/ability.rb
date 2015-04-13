class Ability
  include Hydra::Ability
  
  # Define any customized permissions here.
  def custom_permissions
    if current_user.id == 1 && current_user.email == 'admin@example.org'
      can :manage, :all
    end
  end
end
