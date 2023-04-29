class SessionsController < ApplicationController
    def create
        user = User.find_by(email: params[:session][:email].downcase)
        puts("********************this is the create function*******************")
        puts (user)
        role = params[:session][:role]
        puts (role)
        if user && user.authenticate(params[:session][:password_digest]) && user. role=="customer"
          session[:user_id] = user.id
          set_current_user()
          flash[:notice] = role
          flash[:notice] = "Logged in successfully."
          redirect_to '/vehicles/welcome'
        elsif user && user.authenticate(params[:session][:password_digest]) && user. role=="admin"
          session[:user_id] = user.id
          set_current_user()
          flash[:notice] = role
          flash[:notice] = "Logged in successfully."
          redirect_to '/admin/welcome'
        elsif user && user.authenticate(params[:session][:password_digest]) && user. role=="employee"
          session[:user_id] = user.id
          set_current_user()
          flash[:notice] = role
          flash[:notice] = "Logged in successfully."
          redirect_to '/employee/welcome'
        else
          flash.now[:alert] = "There was something wrong with your login details."
          redirect_to '/login'
        end
      end
       
      def destroy
        session[:user_id] = nil
        flash[:notice] = "You have been logged out."
        redirect_to '/'
      end
end