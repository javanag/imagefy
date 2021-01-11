Rails.application.routes.draw do
  root "images#index"
  devise_for :users

  resources :images
end
