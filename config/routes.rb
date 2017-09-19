Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  devise_scope :user do patch "users/sessions/downgrade" => "users/sessions#downgrade" end
  resources :wikis
  resources :charges, only: [:new, :create]
  root 'wikis#index'
end
