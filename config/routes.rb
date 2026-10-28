Rails.application.routes.draw do
  get "users/edit", to: "pages#not_found"
  get "users/cancel", to: "pages#not_found"
  get "users/password/new", to: "pages#not_found"
  get "users/password/edit", to: "pages#not_found"

  devise_for :users, controllers: { registrations: "users/registrations" }

  root "dashboard#index"

  resource :onboarding, only: %i[new create]

  resources :sites, only: [] do
    post :select, on: :member
  end

  resources :tasks, only: %i[index create update]
  resources :articles, only: %i[index show]

  resources :conversations, only: %i[index show create] do
    resources :messages, only: %i[create]
  end

  resources :notifications, only: [] do
    post :read_all, on: :collection
  end

  resource :account, only: %i[show] do
    post :check_connection
  end

  namespace :admin do
    root "articles#index"
    resources :articles, except: %i[show]
    resources :categories, except: %i[show]
  end

  get "statistics", to: "pages#not_found", as: :statistics
  get "api", to: "pages#not_found", as: :api
  get "audit", to: "pages#not_found", as: :audit
  get "plans", to: "pages#not_found", as: :plans
  get "install", to: "pages#not_found", as: :install
  get "profile/edit", to: "pages#not_found", as: :edit_profile
  get "password/edit", to: "pages#not_found", as: :edit_password
  get "auth/yandex", to: "pages#not_found", as: :yandex_auth

  get "up" => "rails/health#show", as: :rails_health_check

  match "*path", to: "pages#not_found", via: :all
end
