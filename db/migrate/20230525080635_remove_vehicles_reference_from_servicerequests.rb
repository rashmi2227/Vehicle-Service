class RemoveVehiclesReferenceFromServicerequests < ActiveRecord::Migration[7.0]
  def change
    remove_reference :servicerequests, :vehicles, null: false, foreign_key: true
  end
end
