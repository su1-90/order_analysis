Rails.application.routes.draw do
  root "home#index"
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  resources :users, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :items do
    collection do
      post :import_csv
      get :export
      get :import_form
    end
  end

  resources :informations

  post "/forecasts", to: "forecasts#create"
  get "export_forecast", to: "forecasts#export"
end
