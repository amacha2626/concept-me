Rails.application.routes.draw do
  root to: 'home#index'

  get 'home', controller: :home, action: :index
  resources :relationships, only: [:index, :show, :create, :destroy]
  resources :likes, only: [:index, :create, :destroy]
  namespace :api do
    resources :users, only: [:index] do
      member do
        get 'notification', controller: :notifications, action: :index
        patch 'notification', controller: :notifications, action: :update
      end
    end
    resources :posts, only: [:index, :show, :create]
    resources :comments, only: [:create, :destroy]
    post   'signup',  controller: :users,    action: :create
    post   'signin',  controller: :sessions, action: :create
    delete 'signin', controller: :sessions, action: :destroy
    post   'refresh', controller: :refresh,  action: :create
  end
end