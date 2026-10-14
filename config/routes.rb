Rails.application.routes.draw do
  devise_for :users

  root "dashboard#index"

  resources :sites, only: %i[index show]
  resources :queries, only: %i[show]
  resources :audits, only: %i[index show] do
    resources :issues, only: %i[show]
  end
  resources :conversations, only: %i[index show]
  resource :account, only: %i[show]

  get "up" => "rails/health#show", as: :rails_health_check
end
