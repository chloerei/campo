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

  resources :topics, only: [:index, :show, :new, :create, :edit, :update]
  resources :comments, only: [:create, :edit, :update] do
    collection do
      post :preview
    end

    member do
      get :cancel
      delete :trash
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
    resources :users, only: [:index, :show, :destroy]
    resources :topics, only: [:index, :show] do
      member do
        delete :trash
        patch :restore
      end
    end
    resources :comments, only: [:index, :show] do
      member do
        delete :trash
        patch :restore
      end
    end
  end

  if Rails.env.development?
    get 'qunit', to: 'qunit#index'
  end
end
