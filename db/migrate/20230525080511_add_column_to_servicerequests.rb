class AddColumnToServicerequests < ActiveRecord::Migration[7.0]
  def change
    add_column :servicerequests, :user_id, :integer
  end
end
