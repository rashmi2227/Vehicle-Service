class AddColumnsToServicerequest < ActiveRecord::Migration[7.0]
  def change
    add_column :servicerequests, :service_date, :date
  end
end
