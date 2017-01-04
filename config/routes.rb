Rails.application.routes.draw do
  root "destinations#index"
  get 'destinations/index', as: :destinations

  get 'home/index'

  get 'fuel_stations', to: 'destinations#fuel_stations'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
