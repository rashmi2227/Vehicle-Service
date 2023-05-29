class ChangePhoneNoToBigInt < ActiveRecord::Migration[7.0]
  def change
    change_column :user_logins, :phone_no, :bigint
  end
end
