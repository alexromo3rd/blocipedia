Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  devise_scope :user do patch "users/sessions/downgrade" => "users/sessions#downgrade" end
  devise_scope :user do patch "users/sessions/upgrade" => "charges#new" end
  resources :wikis
  resources :charges, only: [:new, :create]
  resources :wikis do
    resources :collaborators, only: [:new, :create, :destroy]
  end
  root 'wikis#index'
end
