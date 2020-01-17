Rails.application.routes.draw do
  root "static_pages#home"
  get "about", to: "static_pages#about"
  get "signup", to: "users#new"
  post "signup", to: "users#create"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resources :users
  resources :lives
  resources :account_activations, only: :edit
  resources :password_resets, only: %i(new create edit update)
end
