Rails.application.routes.draw do
  resources :users
  root "destinations#index"
  get 'destinations/index', as: :destinations

  get 'fuel_stations/', to: 'destinations#fuel_stations'
end
