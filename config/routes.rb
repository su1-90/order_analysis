Rails.application.routes.draw do
  root "home#index"

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  devise_scope :user do
    post 'guest_admin_sign_in', to: 'users/sessions#guest_admin_sign_in'
    post 'guest_user_sign_in', to: 'users/sessions#guest_user_sign_in'
  end

  resources :users, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :items do
    collection do
      post :import_csv
      get :import_csv
      get :export
      get :import_form
      delete :reset_data
      get :check_data
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
