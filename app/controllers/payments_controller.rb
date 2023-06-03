class PaymentsController < ApplicationController
    before_action :authenticate_user_login!
    
    before_action :check_user , only: [:new, :create]

    before_action :check_permission

    def check_permission
        if current_user_login.role!='admin' && current_user_login.role!='customer'
            flash[:notice]='You need admins permssion to access'
            redirect_to root_path
        end
    end

    def check_user
        if current_user_login.present? && current_user_login.role!='admin'
            flash[:notice]='Restricted Access'
            redirect_to root_path
        end
    end

    def form
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

    def check
        if current_user_login.present?
            if current_user_login.admin?
                serviceid = params[:payment][:servicerequest_id]
                @serviceRequest = Servicerequest.find_by(id: serviceid)
                if @serviceRequest
                    if Payment.exists?(servicerequest_id: @serviceRequest.id)
                        flash[:success] = "Payment already added!"
                        redirect_to "/add/payment"
                    else
                        redirect_to "/payment/add/amount/#{@serviceRequest.id}"
                    end
                else 
                    redirect_to '/payment/invalid/serviceno'
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

    def check_pay
        if current_user_login.present?
            if current_user_login.admin?
                serviceid = params[:id]
                @serviceRequest = Servicerequest.find_by(id: serviceid)
                if @serviceRequest
                    if Payment.exists?(servicerequest_id: @serviceRequest.id)
                        flash[:success] = "Payment already added!"
                        redirect_to "/admin/viewservices"
                    else
                        redirect_to "/payment/add/amount/#{@serviceRequest.id}"
                    end
                else 
                    redirect_to '/payment/invalid/serviceno'
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

    def invalidservice
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

    def checkamount
        if current_user_login.present?
            if current_user_login.admin?
                if Payment.where(id: params[:id]).exists?
                    if Payment.exists?(id: params[:id], payment_status: "paid")
                        flash[:success] = "Payment already added!"
                        redirect_to "/payment/status"
                    else
                        redirect_to "/payment/amount/edit/#{params[:id]}"
                    end
                else  
                    flash[:notice]='Invalid Service Number'
                    redirect_to "/payment/status"
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

    def checkstatus
        if current_user_login.present?
            if current_user_login.customer?
                if Payment.where(id: params[:id], payment_status: 'paid').exists?
                    # puts("in true")
                    redirect_to '/payment/done'
                else
                    redirect_to "/payments/#{params[:id]}/pay"
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

    def amount
        if current_user_login.present?
            if current_user_login.admin?
                if Servicerequest.where(id: params[:id]).exists?
                    
                else  
                    flash[:notice]='Invalid Service Number'
                    redirect_to '/admin/viewservices'
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

    def edit
        if current_user_login.present?
            if current_user_login.admin?
                if Payment.where(id: params[:id]).exists?
                    @payment = Payment.find(params[:id])

                else  
                    flash[:notice]='Invalid Payment Number'
                    redirect_to "/payment/status"
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

    def updateamount
        if current_user_login.present?
            if current_user_login.admin?
                @payment = Payment.find(params[:id])    
                if @payment.update(payment_params)
                  redirect_to '/payments/show', notice: "Payment updated successfully."
                else
                  redirect_to '/payments/show' , notice: 'Vehcile update unsuccessful.'
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

    def create
        if current_user_login.present?
            if current_user_login.admin?
                @servicerequest = Servicerequest.find(params[:id])
                if @servicerequest
                    amount = params[:payment][:amount]
                    user_id = @servicerequest.user_id
                    vehicle_id = @servicerequest.vehicle_id
                    service_id = params[:id]
                    payment_status = "unpaid"
                    payment = Payment.create(amount: amount, user_id: user_id, vehicle_id: vehicle_id, servicerequest_id: service_id, payment_status: payment_status)
                    if payment.persisted?
                        flash[:success] = "Amount added succesfully!"
                        redirect_to '/payments/show'
                    else
                        flash[:error] = "Payment Unsuccessful!"
                        redirect_to '/add/payment'
                    end
                else  
                    flash[:error] = "Invalid Service Number!"
                    redirect_to '/add/payment'
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

    def index
        if current_user_login.present?
            if current_user_login.admin?
                @payments = Payment.includes(:user_login, :vehicle).all
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
            if current_user_login.customer?
                @userpayments = Payment.select("payments.id, payments.servicerequest_id, payments.user_id, payments.vehicle_id, payments.amount, payments.payment_status, servicerequests.status").joins(:servicerequest).where(user_id: current_user_login.id).includes(:vehicle)
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
            if current_user_login.customer?
                if Payment.where(id: params[:id]).update(payment_status: "paid")
                    flash[:success] = "Payment status updated successfully!"
                    redirect_to "/payments/all"
                else
                    flash[:success] = "Error updating payment status!"
                    redirect_to "/payments/all"
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

    def paymentdone
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

    def destroy
        if current_user_login.present?
            if current_user_login.admin?
                @payment =  Payment.find_by(id: params[:id])
                # p @payment
                if @payment.payment_status == "paid"
                    redirect_to '/payment/over'
                elsif @payment.destroy
                    redirect_to '/payment/status'
                else 
                    redirect_to '/payment/status'
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
  
      # Only allow a list of trusted parameters through.
      def payment_params
        params.require(:payment).permit(:id, :servicerequest_id, :vehicle_id, :amount, :payment_status)
      end

end