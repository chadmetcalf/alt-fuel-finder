Rails.application.routes.draw do
  # resources :users, only:[:show]
  root "home#index"


  namespace :user do
    get "users/:id", to: "dashboard#show", as: :dashboard
    resources :places, only: [:new, :create]
  end
end
