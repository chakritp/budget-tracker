Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/dashboard' => 'welcome#dashboard', as: :dashboard
  resources :users
  resources :payment_methods
  resources :transactions
end
