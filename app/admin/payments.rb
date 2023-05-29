ActiveAdmin.register Payment do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :servicerequest_id, :vehicle_id, :user_id, :amount, :payment_status
  #
  # or
  #
  # permit_params do
  #   permitted = [:servicerequest_id, :vehicle_id, :user_id, :amount, :payment_status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  index do
    selectable_column
    id_column
    column :servicerequest_id 
    column :payment_status
    column :vehcile_number do |payment|
      payment.vehicle.vehicle_number
    end
    column :user do |payment|
      payment.user_login.user_name
    end
    column :amount
    actions
  end

  filter :servicerequest_id, as: :select, collection: proc { Servicerequest.pluck(:id).uniq }
  filter :user_id, as: :select, collection: proc { UserLogin.pluck(:user_name).uniq }
  filter :vehicle_id, as: :select, collection: proc { Vehicle.pluck(:vehicle_number).uniq }
  filter :amount

  scope :pending_payment_status
  scope :paid_payment_status

end
