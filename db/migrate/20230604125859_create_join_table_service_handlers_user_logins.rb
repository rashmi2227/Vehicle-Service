class CreateJoinTableServiceHandlersUserLogins < ActiveRecord::Migration[6.0]
  def change
    create_join_table :service_handlers, :user_logins, table_name: :handlers_logins do |t|
      t.index [:service_handler_id, :user_login_id], name: 'index_handlers_logins_on_handler_id_and_login_id'
      t.index [:user_login_id, :service_handler_id], name: 'index_handlers_logins_on_login_id_and_handler_id'
      # Add any additional columns or indexes for the join table if needed
    end
  end
end
