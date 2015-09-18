Rails.application.routes.draw do

get '/login', to: 'sessions#new'
post '/sessions', to: 'sessions#create'
delete '/sessions', to: 'sessions#destroy'

resources :users

resources :posts

root 'posts#index'
end
