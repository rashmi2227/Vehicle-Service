class VehiclesController < ApplicationController
  
    # GET /vehicles/1 or /vehicles/1.json
    def show
        @vehicles = Current.user.vehicles
    end
  
    def welcome
  
    end
  
    def insert
        @vehicles=Vehicle.new(vehicle_params)
        respond_to do |format|
            if @vehicles.save
                format.html { redirect_to '/bike/show', notice: "Vehicle was successfully created." }
                format.json { render :show, status: :created, location: @vehicles }
            else
                flash[:register_errors] = @vehicles.errors.full_messages
                redirect_to '/vehicles/insert'
            end
        end
    end
  
    # GET /vehicles/new
    def new
      @vehicle = Vehicle.new
    end
  
    # GET /vehicles/1/edit
    def edit
        @vehicle = Vehicle.find(params[:id])
    end
  
  
    # PATCH/PUT /vehicles/1 or /vehicles/1.json
    def update
        @vehicle = Vehicle.find(params[:id])
    
        if @vehicle.update(vehicle_params)
          redirect_to '/bike/show', notice: "Vehicle updated successfully."
        else
          redirect_to '/bike/update' 
        end
    end
  
    # DELETE /vehicles/1 or /vehicles/1.json
    def destroy
        @vehicle_has_service = Servicerequest.where(vehicle_id: 3)
        if @vehicle_has_service.blank?
          flash[:alert] = "Vehicle has been booked for service."
          redirect_to '/vehicles/alert'
        else
          @vehicless = Vehicle.find(params[:id])
          @vehicless.destroy
    
          respond_to do |format|
          format.html { redirect_to '/bike/show', notice: "Vehicle was successfully destroyed." }
          format.json { head :no_content }
          end
      end
    end

    def alert

    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_vehicle
        @vehicle = Vehicle.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def vehicle_params
        params.require(:vehicle).permit(:vehicle_modal, :purchase_date, :color, :licence_number, :make).merge(user_id: Current.user.id)
      end
  end
  