class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
  # Configura parámetros permitidos para Devise
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Permitir `username` en las acciones de registro y actualización de cuenta
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end
