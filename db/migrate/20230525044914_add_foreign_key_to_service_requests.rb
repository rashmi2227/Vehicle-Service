class AddForeignKeyToServiceRequests < ActiveRecord::Migration[7.0]
  def change
    add_reference :servicerequests, :primary_technician, foreign_key: { to_table: :user_logins }
  end
end
