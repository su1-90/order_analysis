Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  resources :users, only: [:index, :edit, :update, :destroy]
  resources :items

  root "home#index"
end