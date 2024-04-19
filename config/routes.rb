Rails.application.routes.draw do
  resources :favorites, only: [:create, :destroy, :index]
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  root to: 'tops#index'
  resources :blogs do
    collection do
      post :confirm
    end
  end
end
