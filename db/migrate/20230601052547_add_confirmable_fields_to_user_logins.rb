class AddConfirmableFieldsToUserLogins < ActiveRecord::Migration[7.0]
  def change
    add_column :user_logins, :confirmation_token, :string
    add_column :user_logins, :confirmed_at, :datetime
    add_column :user_logins, :confirmation_sent_at, :datetime
    add_column :user_logins, :unconfirmed_email, :string
  end
end
