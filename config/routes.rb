Rails.application.routes.draw do

get '/login', to: 'sessions#new'
post '/sessions', to: 'sessions#create'
delete '/sessions', to: 'sessions#destroy'

resources :users

resources :posts do
	resources :comments, shallow: :true, only: [:create, :destroy]
end 
get '/profile', to: 'users#profile'
get '/profile/:username', to: 'users#show', as: 'profile_user'

root 'posts#index'
end
