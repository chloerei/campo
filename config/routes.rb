Rails.application.routes.draw do
  root 'topics#index'
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
      post 'preview'
    end

    member do
      patch :vote
    end
  end

  if Rails.env.development?
    get 'qunit', to: 'qunit#index'
  end
end
