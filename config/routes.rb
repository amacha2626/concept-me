Rails.application.routes.draw do
  root to: 'home#index'

  resources :relationships, only: [:index, :show, :create, :destroy]
  resources :likes, only: [:index, :create, :destroy]
  namespace :api do
    resources :users, only: [:index]
    resources :posts, only: [:index, :show, :create]
    post   'signup',  controller: :users,    action: :create
    post   'signin',  controller: :sessions, action: :create
    delete 'signin', controller: :sessions, action: :destroy
    post   'refresh', controller: :refresh,  action: :create
  end
end
