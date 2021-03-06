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
    resources :form_templates
    resources :ip_based_groups
  end
  resources :resource, :only => :show
  resources :downloads
  mount HydraEditor::Engine => '/'
  get 'records/ingest_options', :to => "records#ingest_options", :as => :ingest_options

  authenticate :user, lambda { |user| user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end 

  get 'sets/', :to => 'collection#index', :as => :a_to_z
  get 'sets/:set_id', :to => "sets#index", :as => :sets_index
  get 'sets/:set_id/:id', :to => "sets#show", :as => :sets
  get 'sets/:set_id/facet/:id', :to => "sets#facet"
  [:email, :sms, :citation].each do |export_type|
    get "sets/:set_id/#{export_type}", :to => "sets##{export_type}", :as => :"#{export_type}_sets"
  end

  resources :reviewer, :only => [:index, :show] do
    member do
      get 'facet'
      patch 'review'
    end
  end

  
end
