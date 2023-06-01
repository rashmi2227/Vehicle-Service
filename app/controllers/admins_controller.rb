class AdminsController < ApplicationController
    before_action :authenticate_user_login!
    
    before_action :check_user , only: [:new, :create]

    before_action :check_permission

    def check_permission
        if current_user_login.role!='admin'
            flash[:notice]='You don not have access'
            redirect_to root_path
        end
    end

    def check_user
        if current_user_login.present? && current_user_login.role!='admin'
            flash[:notice]='Restricted Access'
            redirect_to root_path
        end
    end
    def welcome
        if current_user_login.present?
            if current_user_login.admin?

            else 
                flash[:notice]='Restricted Access'
                check_current_user_role
            end
        else   
            flash[:notice]='Unauthorised Access'
            redirect_to root_path
        end

    end

    def employee
        if current_user_login.present?
            if current_user_login.admin?

            else 
                flash[:notice]='Restricted Access'
                check_current_user_role
            end
        else   
            flash[:notice]='Unauthorised Access'
            redirect_to root_path
        end
    end
    
    def assign
        if current_user_login.present?
            if current_user_login.admin?
                if Servicerequest.where(id: params[:id]).exists?
                
                else  
                    flash[:notice]='Invalid Service Number'
                    check_current_user_role
                end
            else 
                flash[:notice]='Restricted Access'
                check_current_user_role
            end
        else   
            flash[:notice]='Unauthorised Access'
            redirect_to root_path
        end        
    end

    def check 
        if current_user_login.present?
            if current_user_login.admin?
                # @service_request = Servicerequest.where(id: params[:id])
                # p @servicerequest
                if Servicerequest.where(id: params[:id]).exists?
                    if Servicerequest.joins(:service_handlers).where(id: params[:id], status: 'pending') .exists?(service_handlers: { servicerequest_id: params[:id] })
                        redirect_to '/service_handler/existing'
                    elsif Servicerequest.where(id: params[:id], status: 'done').exists?
                        redirect_to '/service/done'
                    else
                        redirect_to "/admin/assign/#{params[:id]}"
                    end
                else                     
                    flash[:notice]='Invalid Service Number'
                    check_current_user_role 
                end
            else 
                flash[:notice]='Restricted Access'
                check_current_user_role
            end
        else   
            flash[:notice]='Unauthorised Access'
            redirect_to root_path
        end
    end

    def createmployee
        if current_user_login.present?
            if current_user_login.admin?
                user=UserLogin.new(user_params)
                user.role="employee"
                if user.save
                    flash[:notice] = "User created."
                    redirect_to '/view/employees'
                else
                    flash[:register_errors] = user.errors.full_messages
                    redirect_to '/admin/welcome'
                end
            else 
                flash[:notice]='Restricted Access'
                check_current_user_role
            end
        else   
            flash[:notice]='Unauthorised Access'
            redirect_to root_path
        end 

    end

    def createadmin
        if current_user_login.present?
            if current_user_login.admin?
                user=UserLogin.new(user_params)
                user.role="admin"
                if user.save
                    session[:user_id]=user.id
                    flash[:notice] = "User created."
                    redirect_to '/admin/welcome'
                else
                    flash[:register_errors] = user.errors.full_messages
                    redirect_to '/admin/welcome'
                end
            else 
                flash[:notice]='Restricted Access'
                check_current_user_role
            end
        else   
            flash[:notice]='Unauthorised Access'
            redirect_to root_path
        end 

    end

    def assignservice
        if current_user_login.present?
            if current_user_login.admin?

            else 
                flash[:notice]='Restricted Access'
                check_current_user_role
            end
        else   
            flash[:notice]='Unauthorised Access'
            redirect_to root_path
        end 
    end

    def checkservice
        if current_user_login.present?
            if current_user_login.admin?
                serviceid = params[:servicerequest][:servicerequest_id]
                if Servicerequest.exists?(serviceid)
                    redirect_to "/admin/check/#{serviceid}"
                else
                    redirect_to '/admin/assignservice'
                end
            else 
                flash[:notice]='Restricted Access'
                check_current_user_role
            end
        else   
            flash[:notice]='Unauthorised Access'
            redirect_to root_path
        end 
    end

    private 
        def user_params
            params.require(:user_login).permit(:user_name,:email,:password,:password_confirmation, :role, :phone_no)
        end
end