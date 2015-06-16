Rails.application.routes.draw do
  root :to => "catalog#index"
  blacklight_for :catalog
  devise_for :users
  mount Hydra::RoleManagement::Engine => '/'


  get '/admin', :to => 'admin#index', :as => "admin_index"
  resources :resource, :only => :show
  mount HydraEditor::Engine => '/'

  get 'sets/:set_id', :to => "sets#index"
  get 'sets/:set_id/facet/:id', :to => "sets#facet"
end
