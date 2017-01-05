Rails.application.routes.draw do
  # resources :users, only:[:show]
  root "home#index"

  get "users/:id", to: "dashboard#show", as: :dashboard
end
