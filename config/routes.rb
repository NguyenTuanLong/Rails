Rails.application.routes.draw do
  resources :receipts
  resources :records, only: [:index, :show, :create, :destroy]
  resources :line_items
  resources :carts
  resources :posts
  root 'pages#home', as: 'home'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
