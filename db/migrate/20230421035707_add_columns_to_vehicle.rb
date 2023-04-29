class AddColumnsToVehicle < ActiveRecord::Migration[7.0]
  def change
    add_column :vehicles, :make, :string
    add_column :vehicles, :purchase_date, :date
    add_column :vehicles, :color, :string
    add_column :vehicles, :licence_number, :string
  end
end
