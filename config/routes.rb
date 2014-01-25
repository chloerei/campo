Rails.application.routes.draw do
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users, only: [:create] do
    collection do
      get :check_email
      get :check_username
    end
  end

  resources :topics, only: [:index, :show, :new, :create, :edit, :update] do
  end

  resources :posts, only: [:show, :create, :edit, :update] do
    collection do
      post :preview
    end

    member do
      post :like
      delete :like, action: 'unlike'
    end
  end

  resources :notifications, only: [:index, :destroy] do
    collection do
      post :mark
      delete :clear
    end
  end

  root 'topics#index'

  namespace :admin do
    root to: 'dashboard#show'
  end

  if Rails.env.development?
    get 'qunit', to: 'qunit#index'
  end
end
