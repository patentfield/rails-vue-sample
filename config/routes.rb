Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
  get :search, to: 'pages#search'

  resources :jobs, only: [:index, :create]
  resources :notifications, only: [:index, :update, :create, :destroy] do
    collection do
      put :read
    end
  end

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end
