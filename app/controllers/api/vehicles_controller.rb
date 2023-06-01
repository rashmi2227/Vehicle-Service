class Api::VehiclesController < Api::ApiController
  
    # GET /vehicles/1 or /vehicles/1.json
    def show
      if @current_user
        if  @current_user.role == 'customer'
          @user = UserLogin.find_by(id: params[:user_id])
          if @user
            @vehicles = Vehicle.where(user_id: @user)
            if @vehicles.empty?
              render json: { message: "No Vehicle found." } , status: :no_content
            else
              render json: @vehicles , status: :ok
            end
          else
            render json: {message: "No user found with id #{params[:user_id]}"} , status: :no_content
          end
        else  
          render json: { error: 'Access restricted' }, status: :forbidden
        end
      else  
        render json: { error: 'Invalid user' }, status: :unauthorized
      end
    end
  
    def welcome
      # puts(current_user_login.id)
  
    end
  
    def create
      if @current_user
        if @current_user.role == 'customer'
          @user = UserLogin.find_by(id: params[:user_id])
          # puts("======1=========")
          # p @user
          if @user
            @vehicle=Vehicle.new(vehicle_params) 
            # puts("======2=========")
            # p @vehicle  
            if @vehicle.save
              render json: @vehicle, status: :created
            else
              render json: {  error: @vehicle.errors.full_messages } , status: :unprocessable_entity
            end
          else
            render json: {message: "No user found with id #{params[:user_id]}"} , status: :no_content
          end
        else  
          render json: { error: 'Access restricted' }, status: :forbidden
        end
      else  
        render json: { error: 'Invalid user' }, status: :unauthorized
      end
    end
  
    # GET /vehicles/newrails generate migration ChangeColumnName

    def new
      @vehicle = Vehicle.new
    end
  
    # GET /vehicles/1/edit
    def edit
        @vehicle = Vehicle.find(params[:id])
    end
  
  
    # PATCH/PUT /vehicles/1 or /vehicles/1.json
    def update
      if @current_user
        if @current_user.role == 'customer'
          @vehicle = Vehicle.find_by(id: params[:id])
          if @vehicle
            if @vehicle.update(update_vehicle_params)
              render json: @vehicle, status: :accepted
            else
              render json: { error: @vehicle.errors.full_messages } , status: :unprocesable_entity
            end
          else
            render json: { message: "No Vehicle found." } , status: :not_found
          end
        else  
          render json: { error: 'Access restricted' }, status: :forbidden
        end
      else  
        render json: { error: 'Invalid user' }, status: :unauthorized
      end
    end

    def listvehicle

    end

    def checkvehicle
      if @current_user
        if @current_user.role == 'employee'
          vehicle_num = params[:vehicle][:vehicle_number]
          vehicle_num = vehicle_num.upcase
          # puts("=====1========")
          # puts(vehicle_num)
          # puts("================")
          vehicle_id = Vehicle.find_by(vehicle_number: vehicle_num)&.id
          # puts("=====2========")
          # puts(vehicle_id)
          if vehicle_id
            render json: { message: "Vehicle number exists" } , status: :ok
          else
            render json: { message: "No Vehicle found." } , status: :no_content
          end
        else  
          render json: { error: 'Access restricted' }, status: :forbidden
        end
      else 
        render json: { error: 'Invalid user' }, status: :unauthorized
      end
  end
  
    # DELETE /vehicles/1 or /vehicles/1.json
    def destroy
      if @current_user
        if @current_user.role == 'customer'
          @vehicle_id = Vehicle.find_by(id: params[:id]) 
          if @vehicle_id
            @vehicle_has_service = Servicerequest.find_by(vehicle_id: params[:id])
            if @vehicle_has_service
              render json: { message: "Vehicle is under service." } , status: :ok
            elsif @vehicle_id.destroy
              render json: { message: "Vehicle deleted successfully"} , status: :ok
            else
              render json: { error: @vehicle_id.errors.full_messages } , status: :unprocessable_entity
              render json: { error: @vehicle_has_service.errors.full_messages } , status: :unprocessable_entity          
            end
          else
            render json: {message: "No vehicle found with id #{params[:id]}"} , status: :not_found
          end
        else  
          render json: { error: 'Access restricted' }, status: :forbidden
        end
      else  
        render json: { error: 'Invalid user' }, status: :unauthorized
      end
    end

    def details
      if @current_user
        if @current_user.role == 'employee'
          @vehicle_spec = Vehicle.find_by(id: params[:id])
          if @vehicle_spec
            render json: @vehicle_spec , status: :ok
          else 
            render json: {message: "No vehicle found with id #{params[:id]}"} , status: :not_found
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

    def notfound

    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_vehicle
        @vehicle = Vehicle.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def vehicle_params
        params.require(:vehicle).permit(:vehicle_modal, :purchase_date, :color, :vehicle_number, :make, :user_id)
      end

      def update_vehicle_params
        params.require(:vehicle).permit(:vehicle_modal, :purchase_date, :color, :vehicle_number, :make)
      end
  end
  