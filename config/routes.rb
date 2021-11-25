Rails.application.routes.draw do
  
  root to: 'homes#top'
  devise_for :users
  resources :books,only: [:create,:show,:index,:edit,:destroy,:update]
  resources :users, only: [:show, :edit, :update]

end
