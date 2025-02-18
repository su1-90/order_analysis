class CustomFailureApp < Devise::FailureApp
  def redirect_url
    new_user_session_path
  end

  def respond
    if http_auth?
      http_auth
    elsif warden_options[:recall]
      recall
    else
      redirect
    end
  end

  def recall
    store_location_for(:user, attempted_path) unless http_auth? || !request.get? || !devise_controller?
    flash[:alert] = i18n_message(:invalid_login)
    redirect_to redirect_url, status: :see_other
  end
end
