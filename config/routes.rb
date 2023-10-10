Rails.application.routes.draw do
  devise_for :users
  #devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'items#index'
    resources :items do
      resources :purchases, only: [:index, :create]
    end
  end
