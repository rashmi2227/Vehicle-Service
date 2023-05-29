class CreateTableVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :vehicle_modal
      t.date :purchase_date
      t.string :make
      t.string :color
      t.string :vehicle_number

      t.timestamps
    end
  end
end
