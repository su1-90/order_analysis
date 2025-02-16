Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  resources :users, only: [:index, :edit, :update, :destroy]
  resources :items, only: [:index, :show, :new, :create]

  root 'home#index'
end