class VehiclesController < ApplicationController
  before_action :authenticate_user_login!
    
  before_action :check_user , only: [:new, :create]

  before_action :check_permission

  def check_permission
      if current_user_login.role!='customer' && current_user_login.role!='employee'
          flash[:notice]='You need admins permssion to access'
          redirect_to root_path
      end
  end

  def check_user
      if current_user_login.present? && current_user_login.role!='employee' && current_user_login.role!='customer'
          flash[:notice]='Restricted Access'
          redirect_to root_path
      end
  end
  
    # GET /vehicles/1 or /vehicles/1.json
    def show
      if current_user_login.present?
        if current_user_login.customer?
          @currentUser = current_user_login.id 
          @vehicles = Vehicle.where(user_id: @currentUser)
        else 
          flash[:notice]='Restricted Access'
          check_current_user_role
        end
      else   
        flash[:notice]='Unauthorised Access'
        redirect_to root_path
      end 
    end
  
    def welcome
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
  
    def create
      if current_user_login.present?
        if current_user_login.customer?
          @vehicles=Vehicle.new(vehicle_params)
          # p @vehicles
          if @vehicles.save
              respond_to do |format|
                  format.html { redirect_to '/bike/show', notice: "Vehicle was successfully created." }
                  format.json { render :show, status: :created, location: @vehicles }
              end
            else
              # flash[:notice] = "Error adding vehicle!!"
              flash[:register_errors] = @vehicles.errors.full_messages
              redirect_to '/bike/new'
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
  
    # GET /vehicles/newrails generate migration ChangeColumnName

    def new
      if current_user_login.present?
        if current_user_login.customer?
          @vehicle = Vehicle.new
        else 
          flash[:notice]='Restricted Access'
          check_current_user_role
        end
      else   
        flash[:notice]='Unauthorised Access'
        redirect_to root_path
      end 
    end
  
    # GET /vehicles/1/edit
    def edit
      if current_user_login.present?
        if current_user_login.customer?
          @vehicle = Vehicle.find(params[:id])
        else 
          flash[:notice]='Restricted Access'
          check_current_user_role
        end
      else   
        flash[:notice]='Unauthorised Access'
        redirect_to root_path
      end 
    end
  
  
    # PATCH/PUT /vehicles/1 or /vehicles/1.json
    def update
      if current_user_login.present?
        if current_user_login.customer?
          @vehicle = Vehicle.find(params[:id])    
          if @vehicle.update(vehicle_params)
            redirect_to '/bike/show', notice: "Vehicle updated successfully."
          else
            redirect_to '/bike/update' , notice: 'Vehcile update unsuccessful.'
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

    def listvehicle
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

    def checkvehicle
      if current_user_login.present?
        if current_user_login.employee?
          vehicle_num = params[:vehicle][:vehicle_number]
          vehicle_num = vehicle_num.upcase
          vehicle_id = Vehicle.find_by(vehicle_number: vehicle_num)&.id
          if vehicle_id.blank?
            flash[:notice] = "Invalid details!"
            redirect_to '/vehicle/view'
          elsif Vehicle.exists?(vehicle_id)
              flash[:notice] = "Fetching vehicle details"
              redirect_to "/vehicle/details/#{vehicle_id}"
          else
              redirect_to '/vehicle/notfound'
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
  
    # DELETE /vehicles/1 or /vehicles/1.json
    def destroy
      if current_user_login.present?
        if current_user_login.customer?
          @vehicle_has_service = Servicerequest.where(vehicle_id: params[:id])
          if Servicerequest.where(vehicle_id: params[:id], status: "pending").exists?
            flash[:alert] = "Vehicle has been booked for service."
            redirect_to '/vehicles/alert'
          else
            if Payment.where(vehicle_id: params[:id], payment_status: 'paid').destroy_all
              if ServiceHandler.where(vehicle_id: params[:id]).destroy_all
                if Servicerequest.where(vehicle_id: params[:id]).destroy_all
                  if Vehicle.where(id: params[:id]).destroy_all
                    redirect_to '/bike/show', notice: "Deleted successfully."
                  else  
                    redirect_to '/bike/show', notice: "Not deleted successfully."
                  end
                end
              end
            end
            # # @vehicless = Vehicle.find(params[:id])         
      
            # respond_to do |format|
            # format.html { redirect_to '/bike/show', notice: "Vehicle was successfully destroyed." }
            # format.json { head :no_content }
            # end
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

    def details
      if current_user_login.present?
        if current_user_login.employee?
          if Vehicle.where(id: params[:id]).exists?
            if ServiceHandler.where(employee_id: current_user_login.id, vehicle_id: params[:id]).exists? || Servicerequest.where(primary_technician_id: current_user_login.id, vehicle_id: params[:id]).exists?
              @vehicle_spec = Vehicle.find_by(id: params[:id])
            else  
              flash[:notice]='Restricted Access'
              redirect_to '/vehicle/view'
            end
          else  
            flash[:notice]='Invalid Vehicle Number'
            redirect_to '/vehicle/view'
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

    def notfound
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
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_vehicle
        @vehicle = Vehicle.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def vehicle_params
        params.require(:vehicle).permit(:vehicle_modal, :purchase_date, :color, :vehicle_number, :make).merge(user_id: current_user_login.id)
      end
  end
  