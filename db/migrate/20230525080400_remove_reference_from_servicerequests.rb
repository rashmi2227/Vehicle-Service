class RemoveReferenceFromServicerequests < ActiveRecord::Migration[7.0]
  def change
    remove_reference :servicerequests, :user_logins, null: false, foreign_key: true
  end
end
