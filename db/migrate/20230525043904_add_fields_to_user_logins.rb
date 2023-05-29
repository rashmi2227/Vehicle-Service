class AddFieldsToUserLogins < ActiveRecord::Migration[7.0]
  def change
    add_column :user_logins, :role, :string
    add_column :user_logins, :user_name, :string
  end
end
