Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
   resources :orders
  resources :merchandisers
  resources :admins
post "/signup", to: 'merchandisers#create'
get "/me", to:'merchandisers#show'
post "/login", to: 'sessions#create'
delete '/logout', to:'sessions#destroy'
patch '/reset', to:'merchandisers#reset'
end
