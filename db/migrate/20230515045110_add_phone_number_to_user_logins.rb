class AddPhoneNumberToUserLogins < ActiveRecord::Migration[7.0]
  def change
    add_column :user_logins, :phone_no, :integer
  end
end
