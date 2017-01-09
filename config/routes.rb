Rails.application.routes.draw do
  # resources :users, only:[:show]
  root "home#index"
  get 'auth/:provider/callback',  to: 'sessions#create'
  get 'logout',                   to: 'sessions#destroy'


  resources :users, only: [:index]
  namespace :user do
    get "/dashboard", to: "dashboard#show"
    get 'fuel_stations/:id', to: "dashboard#fuel_stations", as: :fuel_stations
    resources :places, only: [:new, :create]
  end

  namespace :api, defaults: {format: :json} do
    namespace :v1 dox
      resources :fuel_stations, only: [:index]
    end
  end
end
