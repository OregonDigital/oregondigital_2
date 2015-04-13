Rails.application.routes.draw do
  root :to => "catalog#index"
  blacklight_for :catalog
  devise_for :users

  resources :resource, :only => :show
  mount HydraEditor::Engine => '/'
end
