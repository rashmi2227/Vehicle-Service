ActiveAdmin.register UserLogin do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :user_name, :role, :phone_no
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :user_name, :role, :phone_no]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :email
    column :role
    column :user_name
    column :phone_no
    actions
  end

  filter :user_name, as: :select, collection: proc { UserLogin.pluck(:user_name).uniq }
  filter :role, as: :select, collection: UserLogin.roles.keys
  filter :email, as: :select, collection: proc { UserLogin.pluck(:email).uniq }

  scope :user_as_employee
  scope :user_as_admin
  scope :user_as_customer
  # scope :with_matching_technician
  # scope :secondary_technician  
  
end
