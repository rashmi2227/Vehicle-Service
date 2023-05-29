class EmployeesController < ApplicationController
    before_action :authenticate_user_login!
    
    before_action :check_user , only: [:new, :create]

    before_action :check_permission

    def check_permission
        if current_user_login.role!='employee'
            flash[:notice]='You need admins permssion to access'
            redirect_to root_path
        end
    end

    def check_user
        if current_user_login.present? && current_user_login.role!='employee'
            flash[:notice]='Restricted Access'
            redirect_to root_path
        end
    end

    def welcome
        if current_user_login.present?
            if current_user_login.employee?

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
            if current_user_login.employee?
                serviceid = params[:servicerequest][:servicerequest_id]
                if Servicerequest.exists?(serviceid)
                    redirect_to "/update/status/#{serviceid}"
                else
                    redirect_to '/employee/error'
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

    def vehicle
        if current_user_login.present?
            if current_user_login.employee?

            else 
                flash[:notice]='Restricted Access'
                check_current_user_role
            end
        else   
            flash[:notice]='Unauthorised Access'
            redirect_to root_path
        end
    end

    def updatestatus
        if current_user_login.present?
            if current_user_login.employee?

            else 
                flash[:notice]='Restricted Access'
                check_current_user_role
            end
        else   
            flash[:notice]='Unauthorised Access'
            redirect_to root_path
        end
    end

    def error
        if current_user_login.present?
            if current_user_login.employee?

            else 
                flash[:notice]='Restricted Access'
                check_current_user_role
            end
        else   
            flash[:notice]='Unauthorised Access'
            redirect_to root_path
        end
    end
end