# frozen_string_literal: true

class UserLogins::RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    attributes = [:user_name ,:phone_no, :role]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    # devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end

  def after_sign_up_path_for(resource)
      flash[:notice] = "Signed In Successfully!"
     vehicles_welcome_path
  end
end
