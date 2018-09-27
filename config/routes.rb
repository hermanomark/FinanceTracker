Rails.application.routes.draw do
  get 'users/my_portfolio'
  
  # added :controllers... for first_name and last_name
  # it means look at registrations controller first
  devise_for :users , :controllers => { :registrations => "user/registrations" }
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'financetrackers#index'
  resources :financetrackers, only: [:index]

  get 'my_portfolio', to: "users#my_portfolio"

  #search_stocks is the url, send the params to search controller and search action
  get 'search_stocks', to: 'stocks#search'

  # only want the create route, want the association to form for the user_stocks table
  resources :user_stocks, only: [:create, :destroy]
end