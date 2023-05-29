# frozen_string_literal: true

class UserLogins::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end
  protected

  def after_sign_in_path_for(resource)
    # Check the role of the user and redirect accordingly
    p resource
    if resource.admin?
      # Redirect to admin dashboard
      admin_welcome_path
    elsif resource.customer?
      # Redirect to customer dashboard
      vehicles_welcome_path
    elsif resource.employee?
      # Redirect to customer dashboard
      employee_welcome_path
    else
      # Redirect to a default path
      root_path
    end
  end

  

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
