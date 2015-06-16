Rails.application.routes.draw do
  root :to => "catalog#index"
  blacklight_for :catalog
  devise_for :users
  mount Hydra::RoleManagement::Engine => '/'


  get '/admin', :to => 'admin#index', :as => "admin_index"
  resources :resource, :only => :show
  mount HydraEditor::Engine => '/'

  get 'sets/:set_id', :to => "sets#index", :as => :sets_index
  get 'sets/:set_id/:id', :to => "sets#show", :as => :sets
  get 'sets/:set_id/facet/:id', :to => "sets#facet"
  get 'sets/:set_id/email', :to => "sets#email", :as => :email_sets
  get 'sets/:set_id/sms', :to => "sets#sms", :as => :sms_sets
  get 'sets/:set_id/citation', :to => "sets#citation", :as => :citation_sets
end
