class Api::ReviewsController < Api::ApiController
    def write

    end

    def create
      if @current_user
        if @current_user.role == 'customer'
          @user = UserLogin.find_by(id: @current_user.id)
          if @user
            @reviewable_name = params[:review][:reviewable_id]
            if @reviewable_name
              if @reviewable_name.match?(/[a-zA-Z]/)
                @reviewable_username = UserLogin.find_by(user_name: @reviewable_name)
                if @reviewable_username
                  @reviewable_id = UserLogin.find_by(id: @reviewable_username.id)
                  if @reviewable_id 
                    @reviewable_type = params[:review][:reviewable_type]
                    if @reviewable_type=="UserLogin"
                      @review = Review.new(reviewfortechnician_params)
                      @review.reviewable_id = @reviewable_id.id
                      @review.user_logins_id = @current_user.id
                      if @review.save
                        render json: @review, status: :created
                      else
                        render json: {  error: @review.errors.full_messages } , status: :unprocessable_entity
                      end
                    else 
                      render json: {message: "Reviewable type should by UserLogin"} , status: :not_found
                    end               
                  else
                    render json: {message: "No employee found with id #{@reviewable_id}"} , status: :not_found
                  end
                else 
                  render json: { message: "No technician found with name #{@reviewable_username}" }, status: :not_found            
                end
              else
                @reviewable_serviceid = Servicerequest.find_by(id: @reviewable_name)
                if @reviewable_serviceid
                  @reviewable_type = params[:review][:reviewable_type]
                  if @reviewable_type == "Servicerequest"
                    @review = Review.new(reviewforservice_params)      
                    @review.reviewable_id = @reviewable_name
                    @review.user_logins_id = @current_user.id  
                    if @review.save
                      render json: @review, status: :created
                    else
                      render json: {  error: @review.errors.full_messages } , status: :unprocessable_entity
                    end
                  else  
                    render json: {message: "Reviewable type should by Servicerequest"} , status: :not_found
                  end
                else  
                  render json: {message: "No servicerequest found with id #{params[:reviewable_id]}"} , status: :not_found
                end           
              end
            else 
              render json: {message: "Invalid reviewable id #{params[:reviewable_id]}"} , status: :not_found
            end 
          else  
            render json: {message: "No user found with id #{params[:user_id]}"} , status: :not_found
          end 
        else  
          render json: { error: 'Access restricted' }, status: :forbidden
        end
      else  
        render json: { error: 'Invalid user' }, status: :unauthorized
      end  
    end

    def show
      if @current_user
        if @current_user.role == 'employee'
          @user = UserLogin.find_by(id: @current_user.id)
          if @user
            # puts(@user.id)
            @reviews = Review.includes(reviewable: :user_login).where(reviewable_id: @current_user.id).distinct
            if @reviews.empty?
              render json: { message: "No Reviews found." } , status: :no_content
            else  
              render json: @reviews , status: :ok
            end
          else   
            render json: {message: "No user found with id #{params[:user_id]}"} , status: :not_found
          end
        else  
          render json: { error: 'Access restricted' }, status: :forbidden
        end
      else 
        render json: { error: 'Invalid user' }, status: :unauthorized
      end      
    end

    def index
      if @current_user
        if @current_user.role == 'admin'
          @reviews = Review.includes(reviewable: :user_login).where.not(comment: nil)
          if @reviews.empty?
            render json: { message: "No Reviews found." } , status: :no_content
          else  
            render json: @reviews , status: :ok
          end
        else 
          render json: { error: 'Access restricted' }, status: :forbidden
        end
      else   
        render json: { error: 'Invalid user' }, status: :unauthorized
      end

    end 
    
    def update
      

    end

    def destroy
      if @current_user
        if @current_user.role == 'admin'
          @review = Review.find_by(id: params[:id])
          if @review
            if @review.destroy
              render json: { message: "Review deleted successfully"} , status: :ok
            else
              render json: { error: @review.errors.full_messages } , status: :unprocessable_entity
            end
          else
            render json: { message: "No review found with the id #{params[:id]}" } , status: :no_content
          end
        else  
          render json: { error: 'Access restricted' }, status: :forbidden
        end
      else   
        render json: { error: 'Invalid user' }, status: :unauthorized
      end
    end

    def user_reviews
      if @current_user
        if @current_user.role == 'admin'
          @user_reviews = Review.where(reviewable_type: "UserLogin")
          if @user_reviews.empty?
            render json: { message: "No Reviews found." } , status: :no_content
          else  
            render json: @user_reviews , status: :ok
          end
        else  
          render json: { error: 'Access restricted' }, status: :forbidden
        end
      else  
        render json: { error: 'Invalid user' }, status: :unauthorized
      end
    end

    def service_reviews
      if @current_user
        if @current_user.role == 'admin'
          @service_reviews = Review.where(reviewable_type: "Servicerequest")
          if @service_reviews.empty?
            render json: { message: "No Reviews found." } , status: :no_content
          else  
            render json: @service_reviews , status: :ok
          end
        else  
          render json: { error: 'Access restricted' }, status: :forbidden
        end
      else  
        render json: { error: 'Invalid user' }, status: :unauthorized
      end
    end
    
    private
    
    def reviewforservice_params
      params.require(:review).permit(:comment, :reviewable_id, :reviewable_type)
    end

    def reviewfortechnician_params
      params.require(:review).permit(:comment, :reviewable_type)
    end
end