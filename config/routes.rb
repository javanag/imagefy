Rails.application.routes.draw do
  root "images#index"
  devise_for :users

  resources :images
  resources :users, param: :username, only: [:show]
  resources :surprise, only: [:index]
end
