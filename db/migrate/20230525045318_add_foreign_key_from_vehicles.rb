class AddForeignKeyFromVehicles < ActiveRecord::Migration[7.0]
  def change
    add_reference :vehicles, :user_login, foreign_key: true
  end
end
