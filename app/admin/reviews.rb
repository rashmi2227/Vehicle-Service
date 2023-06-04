ActiveAdmin.register Review do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :reviewable_type, :reviewable_id, :comment, :user_logins_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:reviewable_type, :reviewable_id, :comment, :user_logins_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :reviewable_type
    column :reviewable do |review| 
      if(review.reviewable_type=="UserLogin")   
        review.user_login.user_name
      else 
        review.reviewable_id
      end
    end
    column :comment
    column :user do |review|
      review.user_login.user_name
    end
    actions
  end

  filter :reviewable_type
  # filter :user_login_id, as: :select, collection: proc { UserLogin.pluck(:user_name).uniq }

  scope :review_for_servicing
  scope :review_for_users
  
end
