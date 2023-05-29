class SessionsController < ApplicationController
  # before_action :authenticate_user_login!
    
  # before_action :check_user , only: [:new, :create]

  # before_action :check_permission

  # def check_permission
  #     if current_user_login.role!='employee'
  #         flash[:notice]='You need admins permssion to access'
  #         redirect_to root_path
  #     end
  # end

  # def check_user
  #     if current_user_login.present? && current_user_login.role!='employee'
  #         flash[:notice]='Restricted Access'
  #         redirect_to root_path
  #     end
  # end

    # def create
    #     user = User.find_by(email: params[:session][:email].downcase)
    #     puts("********************this is the create function*******************")
    #     puts (user)
    #     role = params[:session][:role]
    #     puts (role)
    #     if user && user.authenticate(params[:session][:password_digest]) && user.role=="customer"
    #       session[:user_id] = user.id
    #       # puts("in customer")
    #       # puts(user.role)
    #       # puts(user.id)
    #       # puts(user.user_name)
    #       set_current_user()
    #       flash[:notice] = role
    #       flash[:notice] = "Logged in successfully."
    #       redirect_to '/vehicles/welcome'
    #     elsif user && user.authenticate(params[:session][:password_digest]) && user.role=="admin"
    #       session[:user_id] = user.id
    #       # puts("in admin")
    #       # puts(user.role)
    #       # puts(user.id)
    #       # puts(user.user_name)
    #       set_current_user()
    #       flash[:notice] = role
    #       flash[:notice] = "Logged in successfully."
    #       redirect_to '/admin/welcome'
    #     elsif user && user.authenticate(params[:session][:password_digest]) && user.role=="employee"
    #       session[:user_id] = user.id
    #       # puts("in employee")
    #       # puts(user.role)
    #       # puts(user.id)
    #       # puts(user.user_name)
    #       set_current_user()
    #       flash[:notice] = role
    #       flash[:notice] = "Logged in successfully."
    #       redirect_to '/employee/welcome'
    #     else
    #       flash.now[:alert] = "There was something wrong with your login details."
    #       # puts("in last else")
    #       # puts(user.role)
    #       # puts(user.id)
    #       # puts(user.user_name)
    #       redirect_to '/login'
    #     end
    #   end
       
    #   def destroy
    #     session[:user_id] = nil
    #     flash[:notice] = "You have been logged out."
    #     redirect_to '/'
    #   end
end