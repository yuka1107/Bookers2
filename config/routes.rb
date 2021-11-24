Rails.application.routes.draw do

  get 'home/about' => 'homes#about'
  root to: 'homes#top'
  devise_for :users
  resources :books
  resources :users, only: [:show, :edit, :updata]

end
