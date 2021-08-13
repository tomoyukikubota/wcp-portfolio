Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'

  resources :posts do
    resource :likes, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update]
end
