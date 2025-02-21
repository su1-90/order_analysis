class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  def create
  end

  def informations
    @informations = Information.all
  end

  helper_method :informations # viewで参照可能にする

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_code])
  end

  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from StandardError, with: :render_500

  def render_404
    render template: 'errors/not_found', layout: false, status: :not_found
  end

  def render_500
    render template: 'errors/internal_server_error', layout: false, status: :internal_server_error
  end
  
end
