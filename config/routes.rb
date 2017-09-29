Rails.application.routes.draw do
  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/dashboard' => 'welcome#dashboard', as: :dashboard
  
  resources :users do
    member do
      get 'reset_password', as: :reset_password
      patch 'reset_password' => 'users#update_password'
    end
  end
  resources :payment_methods
  resources :transactions

  get '/login' => 'sessions#new', as: :login
  post '/sessions' => 'sessions#create'

  delete '/logout' => 'sessions#destroy', as: :logout

end
