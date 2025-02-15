Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  resources :items, only: [:index, :show, :new, :create]

  root 'home#index'
end