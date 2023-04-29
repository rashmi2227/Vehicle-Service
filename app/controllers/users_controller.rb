class UsersController < ApplicationController

    def index

    end

    def create
        user=User.new(user_params)
        if user.save
            session[:user_id]=user.id
            flash[:notice] = "User created."
            redirect_to '/login'
        else
            flash[:register_errors] = user.errors.full_messages
            redirect_to '/'
        end
    end

    private 
        def user_params
            params.require(:user).permit(:user_name,:email,:password,:password_confirmation,:role)
        end
end
