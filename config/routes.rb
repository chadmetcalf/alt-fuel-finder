Rails.application.routes.draw do
  root "destinations#index"
  get 'destinations/index', as: :destinations

  get 'fuel_stations/', to: 'destinations#fuel_stations'
end
