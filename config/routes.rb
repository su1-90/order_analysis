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

  # エラーページのルート定義
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  # 全てのその他のルート
  match '*path', to: 'errors#not_found', via: :all
end
