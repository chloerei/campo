Rails.application.routes.draw do
  root 'topics#index'
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'

  resources :users, only: [:create] do
    collection do
      get :check_email
      get :check_username
    end
  end
end
