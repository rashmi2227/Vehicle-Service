class Api::SessionsController < Api::ApiController
    def new
        render json: { notice: 'Welcome to Automotive Repair Shop' }
    end
end