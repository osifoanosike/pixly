class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :conf_params, if: :devise_controller?

  def conf_params
    devise_parameter_sanitizer.for(:sign_up) << :sender_id
        devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:sender_id, :email, :password, :password_confirmation)}

  end
end
