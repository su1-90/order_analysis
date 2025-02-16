# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for(resource)
    if resource.admin?
      items_path
    end
  end

  def after_sign_out_path_for(resource)
    root_path # またはリダイレクトしたいパス
  end
end
