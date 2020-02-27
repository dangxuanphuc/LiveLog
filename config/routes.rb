Rails.application.routes.draw do
  root "static_pages#home"
  get "stats", to: "static_pages#stats"
  get "signup", to: "users#new"
  post "signup", to: "users#create"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resources :users, path: :members do
    resource :admin, only: %i(create destroy)
  end
  resources :songs
  resources :lives
  resources :account_activations, only: :edit
  resources :password_resets, only: %i(new create edit update)
end
