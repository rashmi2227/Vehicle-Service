ActiveAdmin.register Vehicle do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :vehicle_modal, :user_id, :make, :purchase_date, :color, :vehicle_number
  #
  # or
  #
  # permit_params do
  #   permitted = [:vehicle_modal, :user_id, :make, :purchase_date, :color, :vehicle_number]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :vehicle_modal
    column :make
    column :purchase_date
    column :vehicle_number
    column :color
    column :user_login do |vehicle|
      vehicle.user_login.user_name
    end
    actions
  end

  filter :user_login
  filter :user_login, as: :select, collection: UserLogin.all.map{|c| [c.user_name, c.id]}
  filter :color, as: :select, collection: proc { Vehicle.pluck(:color).uniq }
  filter :vehicle_number, as: :select, collection: proc { Vehicle.pluck(:vehicle_number).uniq }
  
end
