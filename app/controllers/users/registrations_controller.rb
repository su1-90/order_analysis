class Users::RegistrationsController < Devise::RegistrationsController
  layout "registration_without_sidebar", only: [:new, :create]
  prepend_before_action :admin_only, only: [:new, :create]
  skip_before_action :require_no_authentication, only: [:new, :create]

  def create
    build_resource(sign_up_params)

    if resource.save
      yield resource if block_given?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_unconfirmed" if is_flashing_format?
        expire_data_after_sign_up!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  protected

  def sign_up_params
    params.require(:user).permit(:user_code, :password, :password_confirmation, :admin)
  end

  def after_sign_up_path_for(resource)
    users_path # サインアップ後のリダイレクト先
  end

  def after_inactive_sign_up_path_for(resource)
    root_path # 未確認アカウントの場合のリダイレクト先
  end

  def admin_only
    unless user_signed_in? && current_user.admin?
      redirect_to root_path, notice: "このページにアクセスする権限がありません."
    end
  end
end
