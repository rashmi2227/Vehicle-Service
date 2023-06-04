ActiveAdmin.register ServiceHandler do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :user_id, :servicerequest_id, :vehicle_number, :vehicle_id, :employee_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :servicerequest_id, :vehicle_number, :vehicle_id, :employee_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :user_login do |service_handler|
      UserLogin.find_by(id: service_handler.user_id).user_name
    end
    column :servicerequest_id
    column :vehicle_number
    column :Employee do |service_handler|
      service_handler.employee.user_name
    end
    actions
  end

  # filter :user_id, as: :select, collection: proc { UserLogin.pluck(:user_name).uniq }
  # filter :employee_id, as: :select, collection: proc { UserLogin.pluck(:user_name).uniq }
  # filter :id, as: :select, collection: proc { Servicerequest.pluck(:id).uniq }
  filter :vehicle_number
  
end
