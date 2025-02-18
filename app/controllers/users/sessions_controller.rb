class Users::SessionsController < Devise::SessionsController
  layout "no_sidebar", only: [:new]

  protected

  def after_sign_in_path_for(resource)
    informations_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end
end