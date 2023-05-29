class RemoveForeignKeyFromVehicles < ActiveRecord::Migration[7.0]
  def change
    remove_reference :vehicles, :user_logins, null: false, foreign_key: true
  end
end
