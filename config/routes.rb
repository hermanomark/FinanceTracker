Rails.application.routes.draw do
  
  # added :controllers... for first_name and last_name
  # it means look at registrations controller first
  devise_for :users , :controllers => { :registrations => "user/registrations" }
  resources :users, only: [:show]
  resources :friendships

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'financetrackers#index'
  resources :financetrackers, only: [:index]

  get 'my_portfolio', to: 'users#my_portfolio'
  get 'my_friends', to: 'users#my_friends'
  get 'search_friends',to: 'users#search'
  post 'add_friend', to: 'users#add_friend'
  
  #search_stocks is the url, send the params to search controller and search action
  get 'search_stocks', to: 'stocks#search'

  # only want the create route, want the association to form for the user_stocks table
  resources :user_stocks, only: [:create, :destroy]
end