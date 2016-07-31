class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :mobile, :email])
      devise_parameter_sanitizer.permit(:sign_in, keys: [:mobile])
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :mobile])
    end

end
