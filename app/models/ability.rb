class Ability
  include Hydra::Ability
  
  # Define any customized permissions here.
  def custom_permissions
    if current_user.admin?
      can [:create, :show, :add_user, :remove_user, :index, :edit], Role
    end
  end
end
