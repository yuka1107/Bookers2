Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get '/home/about',to: 'homes#about', as: "about"

  resources :books,only: [:create,:show,:index,:edit,:destroy,:update]
  resources :users,only: [:show,:index,:edit,:update]

end