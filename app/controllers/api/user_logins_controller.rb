class Api::UserLoginsController < Api::ApiController
    skip_before_action :doorkeeper_authorize!, only: [:create]
    def create
        @user=UserLogin.new(email: user_params[:email], password: user_params[:password], phone_no: user_params[:phone_no], user_name: user_params[:user_name], role: user_params[:role])
        client_app = Doorkeeper::Application.find_by(uid: params[:client_id])
        return render(json: 'Invalid client ID' , status: 403 ) unless client_app
        #return render(json: { error: 'Invalid client ID'}, status: 403) unless client_app

        
        if @user.save
            access_token = Doorkeeper::AccessToken.create(
                            resource_owner_id: @user.id,
                            application_id: client_app.id,
                            refresh_token: generate_refresh_token,
                            expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
                            scopes: ''
                            )
            render(json: {
                    user: {
                    id: @user.id,
                    email: @user.email,
                    phone_no: @user.phone_no,
                    user_name: @user.user_name,
                    role: @user.role,
                    access_token: access_token.token,
                    token_type: 'bearer',
                    expires_in: access_token.expires_in,
                    refresh_token: access_token.refresh_token,
                    created_at: access_token.created_at.to_time.to_i
                           }
                          })
        else
            render(json: { error: @user.errors.full_messages }, status: 422)
        end
    end

    private def user_params
        params.permit(:email, :password, :phone_no, :user_name, :role)
    end

    def generate_refresh_token
        loop do
          token = SecureRandom.hex(32)
          break token unless Doorkeeper::AccessToken.exists?(refresh_token: token)
        end
    end 

    def employee
        if @current_user
            if @current_user.role == 'admin'
                @employees = UserLogin.where(role: 'employee')
                if @employees.empty?
                    render json: { message: "No user with role employee found." } , status: :no_content
                else  
                    render json: @employees , status: :ok
                end
            else  
                render json: { error: 'Access restricted' }, status: :forbidden
            end
        else  
            render json: { error: 'Invalid user' }, status: :unauthorized
        end
    end

    def customer
        if @current_user
            if @current_user.role == 'admin'
                @customers = UserLogin.where(role: 'customer')
                if @customers.empty?
                    render json: { message: "No user with role customer found." } , status: :no_content
                else  
                    render json: @customers , status: :ok
                end
            else  
                render json: { error: 'Access restricted' }, status: :forbidden
            end
        else  
            render json: { error: 'Invalid user' }, status: :unauthorized
        end
    end
    
    def admin
        if @current_user
            if @current_user.role == 'admin'
                @admins = UserLogin.where(role: 'admin')
                if @admins.empty?
                    render json: { message: "No user with role admin found." } , status: :no_content
                else  
                    render json: @admins , status: :ok
                end
            else  
                render json: { error: 'Access restricted' }, status: :forbidden
            end
        else  
            render json: { error: 'Invalid user' }, status: :unauthorized
        end
    end
end