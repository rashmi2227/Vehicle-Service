class CreateServicerequests < ActiveRecord::Migration[7.0]
  def change
    create_table :servicerequests do |t|
      t.string :status
      t.date :start_date
      t.date :end_date
      t.references :user_logins, null: false, foreign_key: true
      t.references :vehicles, null: false, foreign_key: true

      t.timestamps
    end
  end
end
