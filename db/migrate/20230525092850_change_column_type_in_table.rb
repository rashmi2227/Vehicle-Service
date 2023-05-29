class ChangeColumnTypeInTable < ActiveRecord::Migration[7.0]
  def change
    change_column :payments, :amount, :integer
  end
end
