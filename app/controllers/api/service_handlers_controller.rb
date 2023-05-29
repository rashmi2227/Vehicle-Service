class Api::ServiceHandlersController < Api::ApiController
    def create
        if @current_user
            if @current_user.role=='admin'
                @user = UserLogin.find_by(id: params[:user_id])
                # puts("====1=======")
                # p @user
                if @user 
                    @servicerequest = Servicerequest.find_by(id: params[:id])
                    if @servicerequest
                        @vehicle_id = @servicerequest.vehicle_id
                        @vehicle = Vehicle.find_by(id: params[:vehicle_id])
                        if @vehicle.id == @vehicle_id
                            @primary_technician = UserLogin.find_by(id: params[:primary_technician_id])
                            if @primary_technician
                                @employee_ids = params[:employee_id]
                                @employee_ids.each do |employee_id|
                                    @employee = UserLogin.find_by(id: employee_id)
                                    if @employee                             
                                    else  
                                        render json: {message: "Employee is not a valid user"} , status: :not_found and return
                                    end
                                end
                                if @employee
                                    @servicerequest.primary_technician_id = params[:primary_technician_id]
                                    if @servicerequest.save
                                        @services_array = params[:employee_id]
                                        @services_array.each do |service|
                                            @service_handler = ServiceHandler.create(user_id: params[:user_id], employee_id: service, vehicle_id: params[:vehicle_id], vehicle_number: @vehicle.vehicle_number, servicerequest_id: params[:id])
                                        end
                                        render json: @service_handler, status: :created
                                    else  
                                        render json: { error: @servicerequest.errors.full_messages } , status: :unprocesable_entity
                                    end
                                else   
                                    render json: {message: "Employee is not a valid user"} , status: :forbidden
                                end
                            else 
                                render json: {message: "Primary Technician is not a valid user"} , status: :not_found
                            end
                        else  
                            render json: {message: "This vehicle is not registered servicing"} , status: :not_found
                        end 
                    else  
                        render json: {message: "No vehicle found with id #{params[:id]}"} , status: :not_found
                    end
                else 
                    render json: {message: "No service request found with id #{params[:id]}"} , status: :not_found
                end
            else  
                render json: {message: "No user found with id #{params[:user_id]}"} , status: :not_found
            end
        else  
            render json: { error: 'Access restricted' }, status: :forbidden
        end
    end

    def edit
        @service_handler = ServiceHandler.joins(:servicerequest).select('service_handlers.*, servicerequests.*').find(params[:id])
    end

    def index
        if @current_user
            if @current_user.role == 'admin'
                @service_handlers = ServiceHandler.includes(:employee, servicerequest: :primary_technician).where.not(servicerequest_id: nil)
                if @service_handlers.empty?
                    render json: { message: "No service handlers found for any service request." } , status: :no_content
                else  
                    render json: @service_handlers , status: :ok
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

    def update
        if @current_user
            if @current_user.role == 'admin'
                @service_handler = ServiceHandler.find_by(id: params[:id])
                if @service_handler
                    @service_request = @service_handler.servicerequest 
                    if @service_request
                        @employee = UserLogin.find_by(id: params[:employee_id])
                        @primary_technician = UserLogin.find_by(id: params[:primary_technician_id])
                        if @employee && @primary_technician
                            if @service_handler.update(service_handler_params) && @service_request.update(service_request_params)
                                render json: @service_handler, status: :accepted
                            else
                                render json: { error: @service_handler.errors.full_messages } , status: :unprocesable_entity
                                render json: { error: @service_request.errors.full_messages } , status: :unprocesable_entity
                            end
                        else
                            render json: {message: "No employee/ technician found with id #{params[:employee_id]}"} , status: :not_found
                        end                
                    else   
                        render json: {message: "Service handler have no service request"} , status: :not_found 
                    end            
                else  
                    render json: {message: "No service_handler found with id #{params[:id]}"} , status: :not_found
                end 
            else 
                render json: { error: 'Access restricted' }, status: :forbidden
            end
        else  
            render json: { error: 'Invalid user' }, status: :unauthorized
        end       
    end

    def existing

    end

    def destroy
        if @current_user
            if @current_user.role == 'admin'
                @service_handler = ServiceHandler.find_by(id: params[:id])
                if @service_handler
                    @service_id = @service_handler.servicerequest_id
                    if @service_id
                        @service = Servicerequest.find_by(id: @service_id)
                        if @service
                            @service_status = @service.status
                            if @service_status == 'done'
                                if @service_handler.destroy 
                                    render json: { message: "Service Handler deleted successfully"} , status: :ok
                                else  
                                    render json: { error: @service_handler.errors.full_messages } , status: :unprocessable_entity
                                end
                            else  
                                render json: {message: "Service Handler has pending service request assigned"} , status: :not_found
                            end
                        else  
                            render json: {message: "No service request"} , status: :not_found
                        end
                    else   
                        render json: {message: "No service request found with id #{@service_id}"} , status: :not_found
                    end
                else  
                    render json: {message: "No service handler found with id #{params[:id]}"} , status: :not_found
                end
            else  
                render json: { error: 'Access restricted' }, status: :forbidden
            end
        else    
            render json: { error: 'Invalid user' }, status: :unauthorized
        end
    end

    def assignedservices

    end

    def check
        if Servicerequest.joins(:service_handlers).where(id: params[:id], status: 'Pending') .exists?(service_handlers: { servicerequest_id: params[:id] })
            redirect_to '/vehicles/alert'
        elsif Servicerequest.where(id: params[:id], status: 'done').exists?
            redirect_to '/vehcile/service/done'
        else
            redirect_to "/service/delete/#{params[:id]}"
        end
    end

    def service_handler_params
        params.require(:service_handler).permit(:employee_id)
    end

    def service_request_params
        params.require(:service_handler).permit(:primary_technician_id)
    end

end
  