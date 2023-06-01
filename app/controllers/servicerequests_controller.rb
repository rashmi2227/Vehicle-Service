class ServicerequestsController < ApplicationController
    before_action :authenticate_user_login!
    
    before_action :check_user , only: [:new, :create]

    before_action :check_permission

    def check_permission
        if current_user_login.role!='employee' && current_user_login.role!='admin' && current_user_login.role!='customer'
            flash[:notice]='You need permssion to access'
            redirect_to root_path
        end
    end

    def check_user
        if current_user_login.present? && current_user_login.role!='admin' && current_user_login.role!='customer'
            flash[:notice]='Restricted Access'
            redirect_to root_path
        end
    end

    def create
        if current_user_login.present?
            if current_user_login.customer?
                @user = current_user_login.id
                servicerequest = Servicerequest.create(user_id: @user, vehicle_id: params[:id], status: "pending", start_date: params[:servicerequest][:start_date], end_date: params[:servicerequest][:end_date],  primary_technician_id: 40)
                # p servicerequest
                if servicerequest.persisted?
                    flash[:success] = "Your bike service is booked successfully!"
                    redirect_to '/service/booked'
                else
                    # flash[:error] = "Error booking service."
                    flash[:register_errors] = servicerequest.errors.full_messages
                    redirect_to "/service/add/#{params[:id]}/dates"
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

    def destroy
        if current_user_login.present?
            if current_user_login.customer?
                if Servicerequest.where(id: params[:id]).exists?
                    @service = Servicerequest.find(params[:id])
                    @service.destroy  
                    respond_to do |format|
                        format.html { redirect_to '/service/booked', notice: "Booking was successfully destroyed." }
                        format.json { head :no_content }
                    end
                else  
                    flash[:notice]='Invalid Service No'
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

    def date
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

    def checkserviceexisting
        if current_user_login.present?
            if current_user_login.customer?
                if Servicerequest.where(vehicle_id: params[:id], status: 'pending').exists?
                    redirect_to "/service/vehicle/assigned"
                  else
                    redirect_to "/service/add/#{params[:id]}/dates"
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

    def showpendingservice
        if current_user_login.present?
            if current_user_login.employee?
                @service_handlers = ServiceHandler.joins(:servicerequest).where("service_handlers.employee_id = :user_id OR servicerequests.primary_technician_id = :user_id", user_id: current_user_login.id).where(servicerequests: { status: 'pending' }).includes(:employee, servicerequest: :primary_technician)
                @service_handlers = @service_handlers.uniq { |sh| sh.servicerequest_id }
                # p @service_handlers
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
            if current_user_login.employee?
                @service_handlers = ServiceHandler.joins(:servicerequest).where("service_handlers.employee_id = :user_id OR servicerequests.primary_technician_id = :user_id", user_id: current_user_login.id).select(:user_id, :servicerequest_id, :vehicle_id, :vehicle_number, :employee_id, :primary_technician_id).includes(:employee, servicerequest: :primary_technician)   
                @service_handlers = @service_handlers.uniq { |sh| sh.servicerequest_id }
            else 
              flash[:notice]='Restricted Access'
              check_current_user_role
            end
        else   
            flash[:notice]='Unauthorised Access'
            redirect_to root_path
        end   
    end

    def showbookedservice
        if current_user_login.present?
            if current_user_login.customer?
                @service_records = Servicerequest.joins(:vehicle).where("vehicles.user_id = ?", current_user_login.id).includes(:user_login)
            else 
              flash[:notice]='Restricted Access'
              check_current_user_role
            end
        else   
            flash[:notice]='Unauthorised Access'
            redirect_to root_path
        end 
    end

    def show
        if current_user_login.present?
            if current_user_login.admin?
                @servicerequests = Servicerequest.includes(:user_login, :vehicle).all
            else 
              flash[:notice]='Restricted Access'
              check_current_user_role
            end
        else   
            flash[:notice]='Unauthorised Access'
            redirect_to root_path
        end 
    end

    def liststatus
        if current_user_login.present?
            if current_user_login.employee?
                @service = Servicerequest.find_by(id: params[:id])
                if @service
                    @service = Servicerequest.find(params[:id])
                else  
                    flash[:notice]='Invalid Service Number'
                    redirect_to '/update/status'
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

    def update
        if current_user_login.present?
            if current_user_login.employee?
                if Servicerequest.where(id: params[:id]).exists?
                    @status_update = Servicerequest.find(params[:id])    
                    if @status_update.update(status_params)
                      redirect_to '/view/all/service', notice: "Vehicle updated successfully."
                    else
                      redirect_to "/update/status/#{params[:id]}" , notice: 'Error Updating Status'
                    end
                else  
                    flash[:notice]='Invalid Service Number'
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

    def alert
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

    private 
        def status_params
            params.require(:servicerequest).permit(:status)
        end

    private 
        def service_params
            params.require(:servicerequest).permit(:start_date, :end_date)
        end
    # Only allow a list of trusted parameters through.
end