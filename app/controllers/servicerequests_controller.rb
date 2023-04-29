class ServicerequestsController < ApplicationController
    def book
        @user = Current.user.id
        # puts(@user)
        # puts(params[:id])
        servicerequest = Servicerequest.create(user_id: @user, vehicle_id: params[:id], status: "Pending", service_date: params[:servicerequest][:service_date])
        if servicerequest.persisted?
            flash[:success] = "Your bike service is booked successfully!"
            redirect_to '/service/booked'
        else
            flash[:error] = "Error booking service."
            redirect_to '/bike/show'
        end
    end

    def destroy
        @service = Servicerequest.find(params[:id])
        @service.destroy
  
      respond_to do |format|
        format.html { redirect_to '/service/success', notice: "Booking was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    def date

    end

    def booked
        @service_records = Servicerequest.joins(:vehicle).where("vehicles.user_id = ?", Current.user.id)

        if @service_records.any?
            @service_records.each do |service|
            modelname = service.vehicle.vehicle_modal
            servicedate = service.service_date
            status = service.status
            id = service.id
            # Do something with the data, such as displaying it in a view
            end
        end

    end

    def servicerequest
        @servicerequests = Servicerequest.all
        # @servicerequests = Servicerequest.select(:id, :user_id, :service_date, 'vehicles.licence_number').joins(:vehicle)
        # if @servicerequests.any?
        #     @servicerequests.each do |servicerequest|
        #     vehicle_number = servicerequest.vehicle.licence_number
        #     servicedate = servicerequest.service_date
        #     status = servicerequest.status
        #     id = servicerequest.id
        #     # Do something with the data, such as displaying it in a view
        #     end
        # end
    end

    private 
        def service_params
            params.require(:servicerequest).permit(:service_date)
        end
    # Only allow a list of trusted parameters through.
end