Rails.application.routes.draw do
  resources :feeds
  resources :contacts
  resources :favorites, only: [:create, :destroy, :index]
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  root to: 'tops#index'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  resources :blogs do
    collection do
      post :confirm
    end
  end
end
