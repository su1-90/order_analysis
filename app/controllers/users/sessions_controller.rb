class Users::SessionsController < Devise::SessionsController
  layout "no_sidebar", only: [:new]

  def guest_admin_sign_in
    user = User.find_by(user_code: 'admin02') # ゲスト管理者用のユーザーコードに変更
    sign_in user
    redirect_to root_path, notice: 'ゲスト管理者としてログインしました。'
  end

  def guest_user_sign_in
    user = User.find_by(user_code: 'user02') # ゲストユーザー用のユーザーコードに変更
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  protected

  def after_sign_in_path_for(resource)
    informations_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end
end
