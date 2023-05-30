class UsersController < ApplicationController
    before_action :authenticate_user_login!
    
    before_action :check_user , only: [:new, :create]

    before_action :check_permission

    def check_permission
        if current_user_login.role!='employee' && current_user_login.role!='admin'
            flash[:notice]='You need admins permssion to access'
            redirect_to root_path
        end
    end

    def check_user
        if current_user_login.present? && current_user_login.role!='employee' && current_user_login.role!='admin'
            flash[:notice]='Restricted Access'
            redirect_to root_path
        end
    end

    def index

    end

    def view
        @users = UserLogin.where(role: 'employee').order(:user_name)
    end


    private 
        def user_params
            params.require(:user).permit(:user_name,:email,:password,:password_confirmation)
        end
end