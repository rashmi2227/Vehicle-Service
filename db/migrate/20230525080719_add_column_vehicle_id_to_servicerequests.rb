class AddColumnVehicleIdToServicerequests < ActiveRecord::Migration[7.0]
  def change
    add_column :servicerequests, :vehicle_id, :integer
  end
end
