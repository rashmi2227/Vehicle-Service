class Api::ServicerequestsController < Api::ApiController
    def create
        if @current_user
            if @current_user.role == 'customer'
                @user = UserLogin.find_by(id: @current_user.id)
                if @user
                    @vehicle = Vehicle.find_by(id: params[:id])
                    if @vehicle
                        @service_existing = Servicerequest.where(vehicle_id: params[:id], status: 'Pending')
                        if @service_existing
                            render json: { message: "Service Request already done"} , status: :ok
                        else 
                            @servicerequest = Servicerequest.new(servicerequests_params)
                            @servicerequest.vehicle_id = @vehicle.id
                            if @servicerequest.save
                                render json: @servicerequest, status: :created
                            else
                                render json: {  error: @servicerequest.errors.full_messages } , status: :unprocessable_entity
                            end  
                        end                          
                    else
                        render json: {message: "No vehicle found with id #{params[:id]}"} , status: :not_found 
                    end
                else
                    render json: {message: "No user found with id #{@current_user.id}"} , status: :not_found
                end
            else  
                render json: { error: 'Access restricted' }, status: :forbidden
            end
        else   
            render json: { error: 'Invalid user' }, status: :unauthorized
        end

    end

    def destroy
        if @current_user
            if @current_user.role == 'customer'
                @service = Servicerequest.find_by(id: params[:id])
                if @service
                    if Servicerequest.joins(:service_handlers).where(id: params[:id], status: 'Pending') .exists?(service_handlers: { servicerequest_id: params[:id] })
                        render json: { message: "Vehicle is under service"} , status: :ok
                    elsif Servicerequest.where(id: params[:id], status: 'done').exists? 
                        render json: { message: "Vehicle servicing completed deletion cant be performed"} , status: :ok 
                    elsif Payment.where(servicerequest_id: params[:id], payment_status: 'unpaid').exists?
                        render json: { message: "Payment is pending"} , status: :ok          
                    elsif Payment.where(servicerequest_id: params[:id], payment_status: 'paid').destroy_all
                        if ServiceHandler.where(servicerequest_id: params[:id]).destroy_all
                            if Servicerequest.where(id: params[:id]).destroy_all
                                render json: { message: "Service Request deleted successfully"} , status: :ok
                            else 
                                render json: { error: @service.errors.full_messages } , status: :unprocessable_entity 
                            end
                        else  
                            render json: { error: @service.errors.full_messages } , status: :unprocessable_entity
                        end
                    else
                        render json: { error: @service.errors.full_messages } , status: :unprocessable_entity
                    end
                else
                    render json: {message: "No Service Request found with id #{params[:id]}"} , status: :not_found
                end
            else  
                render json: { error: 'Access restricted' }, status: :forbidden
            end
        else  
            render json: { error: 'Invalid user' }, status: :unauthorized
        end
    end

    def date

    end

    def completed_service
        if @current_user
            if @current_user.role == 'admin'
                @completed_service = Servicerequest.where(status: "done")
                if @completed_service.empty?
                    render json: { message: "No services is completed." } , status: :no_content
                  else  
                    render json: @completed_service , status: :ok
                  end
            else  
                render json: { error: 'Access restricted' }, status: :forbidden
            end
        else  
            render json: { error: 'Invalid user' }, status: :unauthorized
        end
    end

    def checkserviceexisting
        if @current_user
            if @current_user.role == 'customer'
                @vehicle = Vehicle.find_by(id: params[:id])
                if @vehicle
                    @service = Servicerequest.find_by(vehicle_id: params[:id], status: 'Pending')
                    if @service
                        render json: { message: "Vehicle has a service request"} , status: :ok
                    else
                        render json: { message: "Vehicle has no service request"} , status: :no_content
                    end 
                else 
                    render json: {message: "No vehicle found with id #{params[:id]}"} , status: :no_content 
                end 
            else  
                render json: { error: 'Access restricted' }, status: :forbidden
            end
        else  
            render json: { error: 'Invalid user' }, status: :unauthorized
        end      
    end

    def showpendingservice
        if @current_user
            if @current_user.role == 'employee'
                @user = UserLogin.find_by(id: params[:user_id])
                if @user
                    if @user.role=="employee"
                        @service_handlers = ServiceHandler.joins(:servicerequest).where("service_handlers.employee_id = :user_id OR servicerequests.primary_technician_id = :user_id", user_id: @current_user.id).where(servicerequests: { status: 'Pending' }).includes(:employee, servicerequest: :primary_technician)
                        if @service_handlers.empty?
                            render json: { message: "No pending service request." } , status: :ok
                        else
                            render json: @service_handlers, status: :ok
                        end
                    else
                        render json: {message: "User is not an employee."} , status: :not_found 
                    end 
                else 
                    render json: {message: "No user found with id #{params[:user_id]}"} , status: :not_found
                end
            else  
                render json: { error: 'Access restricted' }, status: :forbidden
            end
        else  
            render json: { error: 'Invalid user' }, status: :unauthorized
        end
    end

    def index
        if @current_user
            if @current_user.role == 'employee'
                @user = UserLogin.find_by(id: params[:user_id])
                if @user
                    if @user.role=="employee"
                        @service_handlers = ServiceHandler.joins(:servicerequest).where("service_handlers.employee_id = :user_id OR servicerequests.primary_technician_id = :user_id", user_id: @current_user.id).select(:user_id, :servicerequest_id, :vehicle_id, :vehicle_number, :employee_id, :primary_technician_id).includes(:employee, servicerequest: :primary_technician)   
                        if @service_handlers.empty?
                            render json: { message: "No service request assigned untill." } , status: :no_content
                        else
                            render json: @service_handlers, status: :ok
                        end
                    else
                        render json: {message: "User is not an employee"} , status: :forbidden
                    end 
                else 
                    render json: {message: "No user found with id #{params[:user_id]}"} , status: :not_found
                end
            else 
                render json: { error: 'Access restricted' }, status: :forbidden
            end
        else   
            render json: { error: 'Invalid user' }, status: :unauthorized
        end
    end

    def showbookedservice
        if @current_user
            if @current_user.role == 'customer'
                @user = UserLogin.find_by(id: params[:user_id])
                if @user
                    if @user.role=="customer"
                        @service_records = Servicerequest.joins(:vehicle).where("vehicles.user_id = ?", @user).includes(:user_login)
                        if @service_records.empty?
                            render json: {message: "User has not booked any service"} , status: :no_content
                        else
                            render json: @service_records, status: :ok
                        end
                    else 
                        render json: {message: "User is not a customer"} , status: :forbidden
                    end            
                else 
                    render json: {message: "No user found with id #{params[:user_id]}"} , status: :not_found
                end
            else   
                render json: { error: 'Access restricted' }, status: :forbidden
            end
        else   
            render json: { error: 'Invalid user' }, status: :unauthorized
        end
    end

    def show
        if @current_user
            if @current_user.role == 'admin'
                @user = UserLogin.find_by(id: params[:user_id])
                # puts("==============1============")
                # p @user
                if @user
                    if @user.role=="admin"
                        @servicerequests = Servicerequest.includes(:user_login, :vehicle).all
                        if @servicerequests.empty?
                            render json: {message: "No user has booked any service request"} , status: :no_content
                        else
                            render json: @servicerequests, status: :ok
                        end
                    else 
                        render json: {message: "User is not an admin"} , status: :forbidden
                    end            
                else 
                    render json: {message: "No user found with id #{params[:user_id]}"} , status: :not_found
                end
            else  
                render json: { error: 'Access restricted' }, status: :forbidden
            end
        else  
            render json: { error: 'Invalid user' }, status: :unauthorized
        end
    end

    def liststatus
        @service = Servicerequest.find(params[:id])
    end

    def update
        if @current_user
            if @current_user.role == 'employee'
                @user = UserLogin.find_by(id: params[:user_id])
                if @user
                    if @user.role=="employee"
                        @servicerequest = Servicerequest.find_by(id: params[:id])
                        if @servicerequest
                            if @servicerequest.update(status_params)
                                render json: @servicerequest, status: :accepted
                            else 
                                render json: { error: @servicerequest.errors.full_messages } , status: :unprocesable_entity
                            end
                        else 
                            render json: {message: "No service request found with id #{params[:id]}"} , status: :not_found
                        end
                    else 
                        render json: {message: "Service status can be updated only by an employee"} , status: :ok
                    end            
                else
                    render json: {message: "No user found with id #{params[:user_id]}"} , status: :not_found
                end 
            else  
                render json: { error: 'Access restricted' }, status: :forbidden
            end
        else  
            render json: { error: 'Invalid user' }, status: :unauthorized
        end       
    end

    def alert

    end

    private 
        def status_params
            params.require(:servicerequest).permit(:status)
        end

        def service_params
            params.require(:servicerequest).permit(:start_date, :end_date)
        end

        def servicerequests_params
            params.require(:servicerequest).permit(:status, :start_date, :end_date, :primary_technician_id).merge(user_id: @current_user.id)
        end

        
    # Only allow a list of trusted parameters through.
end