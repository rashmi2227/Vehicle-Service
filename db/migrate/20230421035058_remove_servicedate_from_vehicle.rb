class RemoveServicedateFromVehicle < ActiveRecord::Migration[7.0]
  def change
    remove_column :vehicles, :service_date, :date
  end
end
