Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'

  resources :posts
  resources :users, only: [:index, :show, :edit, :update]
end
