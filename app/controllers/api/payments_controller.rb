class Api::PaymentsController < Api::ApiController
    def form

    end

    def check
        serviceid = params[:payment][:servicerequest_id]
        @serviceRequest = Servicerequest.find_by(id: serviceid)
        if @servicerequest
            if Payment.exists?(servicerequest_id: @serviceRequest.id)
                flash[:success] = "Payment already added!"
                redirect_to "/payment/status"
            else
                redirect_to "/payment/add/amount/#{@serviceRequest.id}"
            end
        else 
            redirect_to '/payment/invalid/serviceno'
        end
    end

    def invalidservice

    end

    def checkamount
        if Payment.exists?(id: params[:id], payment_status: "paid")
            flash[:success] = "Payment already added!"
            redirect_to "/payment/status"
        else
            redirect_to "/payment/amount/edit/#{params[:id]}"
        end
    end

    def checkstatus
        if Payment.where(id: params[:id], payment_status: 'paid').exists?
            redirect_to '/payment/done'
        else
            redirect_to "/payments/#{params[:id]}/pay"
        end
    end

    def amount
        @servicerequest = Servicerequest.find(params[:id])
    end

    def edit
        @payment = Payment.find(params[:id])
    end

    def updateamount
        if @current_user
            if @current_user.role == 'admin'
                @payment = Payment.find_by(id: params[:id])
                if @payment
                    if @payment.payment_status=="paid"
                        render json: {message: "Payment is done. Action cannot be performed"} , status: :forbidden
                    else  
                        if @payment.update(payment_params)
                            render json: @payment, status: :accepted
                          else
                            render json: { error: @payment.errors.full_messages } , status: :unprocesable_entity
                        end
                    end
                else   
                    render json: {message: "No payment found with id #{params[:id]}"} , status: :not_found
                end 
            else  
                render json: { error: 'Access restricted' }, status: :forbidden
            end
        else 
            render json: { error: 'Invalid user' }, status: :unauthorized
        end        
    end

    def create
        if @current_user
            if @current_user.role == 'admin'
                @user = UserLogin.find_by(id: params[:user_id])
                if @user
                    @servicerequest = Servicerequest.find_by(id: params[:servicerequest_id])
                    if @servicerequest 
                        @vehicle = Vehicle.find_by(id: params[:vehicle_id])
                        if @vehicle
                            @checkExistence = Payment.find_by(servicerequest_id: params[:servicerequest_id], payment_status: "unpaid")
                            if @checkExistence                        
                                render json: {message: "Payment request already generated"} , status: :ok
                            else 
                                @servicePending = Servicerequest.find_by(id: params[:servicerequest_id], status: "pending")
                                if @servicePending
                                    @payment = Payment.new(payment_params)
                                    @payment.servicerequest_id = @servicerequest.id
                                    if @payment.save
                                        render json: @payment, status: :created
                                    else
                                        render json: { error: @payment.errors.full_messages } , status: :unprocesable_entity
                                    end 
                                else   
                                    render json: {message: "No pending service request found for which payment can be created"} , status: :ok
                                end                        
                            end                    
                        else    
                            render json: {message: "No vehicle found with id #{params[:vehicle_id]}"} , status: :not_found  
                        end                
                    else  
                        render json: {message: "No Service Request found with id #{params[:id]}"} , status: :not_found
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
            if @current_user.role == 'admin'
                @payments = Payment.includes(:user_login, :vehicle).all
                if @payments.empty?
                    render json: { message: "No Payments found." } , status: :no_content
                else  
                    render json: @payments , status: :ok
                end
            else  
                render json: { error: 'Access restricted' }, status: :forbidden
            end
        else  
            render json: { message: 'Invalid user' }, status: :unauthorized
        end        
    end

    def show
        if @current_user
            if @current_user.role == 'customer'
                @user = UserLogin.find_by(id: @current_user.id)
                if @user    
                    @userpayments = Payment.select("payments.id, payments.servicerequest_id, payments.user_id, payments.vehicle_id, payments.amount, payments.payment_status, servicerequests.status").joins(:servicerequest).where(user_id: @user.id).includes(:vehicle)
                    if @userpayments.empty?
                        render json: { message: "No Payments found." } , status: :not_found
                    else 
                        render json: @userpayments , status: :ok
                    end
                else  
                    render json: {message: "No user found with id #{params[:user_id]}"} , status: :not_found
                end
            else  
                render json: { error: 'Access restricted' }, status: :forbidden
            end
        else   
            render json: { message: 'Invalid user' }, status: :unauthorized
        end
    end

    def update
        if @current_user 
            if @current_user.role == 'customer'
                @payment = Payment.find_by(id: params[:id])
                if @payment
                    if @payment.update(update_payment_status_params)
                        render json: @payment, status: :accepted
                    else 
                        render json: { error: @payment.errors.full_messages } , status: :unprocesable_entity
                    end
                else  
                    render json: {message: "No payment found with id #{params[:id]}"} , status: :not_found
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
            if @current_user.role == 'admin'
                @payment =  Payment.find_by(id: params[:id])
                if @payment
                    if @payment.payment_status == "paid"
                        render json: {message: "Payment is done. Action cannot be performed"} , status: :forbidden
                    else  
                        if @payment.destroy
                            render json: { message: "Payment Request deleted successfully"} , status: :ok
                        else 
                            render json: { error: @payment.errors.full_messages } , status: :unprocessable_entity
                        end
                    end
                else   
                    render json: {message: "No payment found with id #{params[:id]}"} , status: :not_found
                end
            else 
                render json: { error: 'Access restricted' }, status: :forbidden
            end
        else  
            render json: { error: 'Invalid user' }, status: :unauthorized
        end        
    end

    private
  
      # Only allow a list of trusted parameters through.
        def payment_params
            params.require(:payment).permit(:vehicle_id, :user_id, :amount, :payment_status)
        end
      
        def update_payment_status_params
            params.require(:payment).permit(:payment_status)
        end 
end