ActiveAdmin.register Servicerequest do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :status, :user_id, :vehicle_id, :start_date, :primary_technician_id, :end_date
  #
  # or
  #
  # permit_params do
  #   permitted = [:status, :user_id, :vehicle_id, :start_date, :primary_technician_id, :end_date]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :status
    column :user_login do |servicerequest|
      servicerequest.user_login.user_name
    end
    column :vehicle_number do |servicerequest|
      servicerequest.vehicle.vehicle_number
    end
    column :start_date
    column :end_date
    column :primary_technician do |servicerequest|
      servicerequest.primary_technician.user_name
    end
    actions
  end

  filter :primary_technician_id, as: :select, collection: -> { UserLogin.pluck(:user_name, :id) }
  filter :vehicle_id, as: :select, collection: proc { Vehicle.pluck(:vehicle_number).uniq }
  filter :start_date
  filter :end_date
  filter :status

  scope :pending_service
  scope :servicing_completed

end
