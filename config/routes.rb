Rails.application.routes.draw do
  resources :transactions
  resources :credit_cards
  resources :products
  root 'home#index'
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: "users#new", as: 'signup'
  get 'login', to: "sessions#new", as: 'login'
  delete 'logout', to: "sessions#destroy", as: 'logout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
