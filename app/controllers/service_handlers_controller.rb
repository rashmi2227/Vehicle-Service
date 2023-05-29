class ServiceHandlersController < ApplicationController
    before_action :authenticate_user_login!
    
    before_action :check_user , only: [:new, :create]

    before_action :check_permission

    def check_permission
        if current_user_login.role!='employee' && current_user_login.role!="admin" && current_user_login.role!='customer'
            flash[:notice]='You need admins permssion to access'
            redirect_to root_path
        end
    end

    def check_user
        if current_user_login.present? && current_user_login.role!='employee' && current_user_login.role!="admin" && current_user_login.role!='customer'
            flash[:notice]='Restricted Access'
            redirect_to root_path
        end
    end

    def create
        if current_user_login.present?
            if current_user_login.admin?
                primary_technician_id = params[:servicerequest][:primary_technician_id]
                vehicle_id = Servicerequest.find(params[:id]).vehicle_id
                user_id = Servicerequest.find(params[:id]).user_id
                # puts(user_id)
                vehicle_number = Vehicle.find(vehicle_id).vehicle_number
                servicerequestid = params[:id]
                # p servicerequestid
                Servicerequest.where(id: servicerequestid).update(primary_technician_id: primary_technician_id)
                services_array = params[:servicehandler][:subhandler]
                # p services_array
                services_array.each do |service|
                    ServiceHandler.create(user_id: user_id, employee_id: service, vehicle_id: vehicle_id, vehicle_number: vehicle_number, servicerequest_id: servicerequestid)
                end
                redirect_to '/serviceassigned/show'
            else 
              flash[:notice]='Restricted Access'
              check_current_user_role
            end
        else   
            flash[:notice]='Unauthorised Access'
            redirect_to root_path
        end 
    end

    def edit
        if current_user_login.present?
            if current_user_login.admin?
                @service_handler = ServiceHandler.joins(:servicerequest).select('service_handlers.*, servicerequests.*').find(params[:id])
            else 
              flash[:notice]='Restricted Access'
              check_current_user_role
            end
        else   
            flash[:notice]='Unauthorised Access'
            redirect_to root_path
        end 
    end

    def index
        if current_user_login.present?
            if current_user_login.admin?
                @service_handlers = ServiceHandler.includes(:employee, servicerequest: :primary_technician).where.not(servicerequest_id: nil)
            else 
                flash[:notice]='Restricted Access'
                check_current_user_role
            end
        else   
            flash[:notice]='Unauthorised Access'
            redirect_to root_path
        end 
    end

    def alert 
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

    def checkstatus
        if current_user_login.present?
            if current_user_login.admin?
                @service_handler = ServiceHandler.find_by(id: params[:id])
                @servicerequest = Servicerequest.find_by(id: @service_handler.servicerequest_id)
                if @servicerequest.status == "done"
                    redirect_to '/service/edit'
                else
                    redirect_to "/service/edit/#{params[:id]}"
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

    def done
        if current_user_login.present?
            if current_user_login.customer?
    
            else 
                flash[:notice]='Restricted Access'
                check_current_user_role
            end
        else   
            flash[:notice]='Unauthorised Access'
            redirect_to root_path
        end 
    end

    def update
        if current_user_login.present?
            if current_user_login.admin?
                @service_handler = ServiceHandler.find(params[:id])
                @service_request = @service_handler.servicerequest     
                if @service_handler.update(service_handler_params) && @service_request.update(service_request_params)
                    redirect_to "/serviceassigned/show", notice: "Service handler updated successfully."
                else
                    render :edit
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

    def existing
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

    def assignedservices
        if current_user_login.present?
            if current_user_login.customer?
    
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
            if current_user_login.customer?
                if Servicerequest.joins(:service_handlers).where(id: params[:id], status: 'pending') .exists?(service_handlers: { servicerequest_id: params[:id] })
                    redirect_to '/vehicles/alert'
                elsif Servicerequest.where(id: params[:id], status: 'done').exists?
                    redirect_to '/vehcile/service/done'
                else
                    redirect_to "/service/delete/#{params[:id]}"
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

    def service_handler_params
        params.require(:service_handler).permit(:employee_id)
    end

    def service_request_params
        params.require(:service_handler).permit(:primary_technician_id)
    end

end
  