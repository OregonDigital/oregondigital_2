Rails.application.routes.draw do
  require 'sidekiq/web'

  mount Blacklight::Oembed::Engine, at: 'oembed'
  root :to => "catalog#index"
  blacklight_for :catalog
  devise_for :users
  mount Hydra::RoleManagement::Engine => '/'


  get '/admin', :to => 'admin#index', :as => "admin_index"
  namespace :admin do
    resources :facets
  end
  resources :resource, :only => :show
  mount HydraEditor::Engine => '/'
  mount Sidekiq::Web => '/sidekiq'

  get 'sets/:set_id', :to => "sets#index", :as => :sets_index
  get 'sets/:set_id/:id', :to => "sets#show", :as => :sets
  get 'sets/:set_id/facet/:id', :to => "sets#facet"
  [:email, :sms, :citation].each do |export_type|
    get "sets/:set_id/#{export_type}", :to => "sets##{export_type}", :as => :"#{export_type}_sets"
  end
end
