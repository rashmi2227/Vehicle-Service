class ReviewsController < ApplicationController
  before_action :authenticate_user_login!
    
  before_action :check_user , only: [:new, :create]

  before_action :check_permission

  def check_permission
      if current_user_login.role!='employee' && current_user_login.role!='admin' && current_user_login.role!='customer' 
          flash[:notice]='You need permssion to access'
          redirect_to root_path
      end
  end

  def check_user
      if current_user_login.present? && current_user_login.role!='employee' && current_user_login.role!='admin' && current_user_login.role!='customer' 
          flash[:notice]='Restricted Access'
          redirect_to root_path
      end
  end

    def write
      if current_user_login.present?
        if current_user_login.customer?

        else 
          flash[:notice]='Restricted Access'
          check_current_user_role
        end
      else   
        flash[:notice]='Unauthorised Access'
        redirect_to root_path
      end 
    end

    def create
      if current_user_login.present?
        if current_user_login.customer?
          reviewable_id = params[:review][:reviewable_id]
          if reviewable_id.match?(/[a-zA-Z]/)
            user = UserLogin.find_by(user_name: reviewable_id)
            if user
              review = Review.create(user_logins_id: current_user_login.id, reviewable_id: user.id, reviewable_type: params[:review][:reviewable_type], comment: params[:review][:comment])
              if review.persisted?
                puts("done")
                redirect_to '/vehicles/welcome'
              else
                flash[:success] = "Error saving review"
                redirect_to '/vehicles/welcome'
                  puts("not done")
              end
            else
              flash[:error] = "Name not found"
              redirect_to '/vehicles/welcome'
            end
          else
            @review = Review.new(review_params)        
            if @review.save
              flash[:success] = "Review saved successfully"
              redirect_to '/vehicles/welcome'
            else
              flash[:error] = "Error saving review"
              redirect_to '/vehicles/welcome'
            end
          end
        else 
          flash[:notice]='Restricted Access'
          check_current_user_role
        end
      else   
        flash[:notice]='Unauthorised Access'
        redirect_to root_path
      end         
    end

    def show
      if current_user_login.present?
        if current_user_login.employee?
          @reviews = Review.includes(reviewable: :user_login).where(reviewable_id: current_user_login.id).distinct
        else 
          flash[:notice]='Restricted Access'
          check_current_user_role
        end
      else   
        flash[:notice]='Unauthorised Access'
        redirect_to root_path
      end 
    end

    def index
      if current_user_login.present?
        if current_user_login.admin?
          @reviews = Review.includes(reviewable: :user_login).where.not(comment: nil)
        else 
          flash[:notice]='Restricted Access'
          check_current_user_role
        end
      else   
        flash[:notice]='Unauthorised Access'
        redirect_to root_path
      end 
    end 
    
    def update

    end

    def destroy

    end
    
    private
    
    def review_params
        params.require(:review).permit(:comment, :reviewable_id, :reviewable_type).merge(user_logins_id: current_user_login.id)
    end
end