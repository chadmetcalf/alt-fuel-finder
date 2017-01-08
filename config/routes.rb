Rails.application.routes.draw do
  # resources :users, only:[:show]
  root "home#index"
  get 'auth/:provider/callback',  to: 'sessions#create'

  resources :users, only: [:index]
  namespace :user do
    get "users/:id", to: "dashboard#show", as: :dashboard
    get 'fuel_stations/:id', to: "dashboard#fuel_stations", as: :fuel_stations
    resources :places, only: [:new, :create]
  end
end
