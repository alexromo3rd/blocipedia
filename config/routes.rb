Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  resources :wikis
  resources :charges, only: [:new, :create]
  root 'wikis#index'
end
