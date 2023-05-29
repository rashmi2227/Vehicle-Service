class ApplicationController < ActionController::Base
  
    before_action :set_current_user
    # before_action :authenticate_user_login!
        
    def set_current_user
        if session[:user_id]
            Current.user= User.find_by(id: session[:user_id])
        end
    end

    def check_current_user_role
        if current_user_login.employee?
           redirect_to employee_welcome_path
        elsif current_user_login.admin?
            redirect_to admin_welcome_path
        elsif current_user_login.customer?
            redirect_to vehicles_welcome_path
        else 
            redirect_ to root_path
        end    
    end
      
end
