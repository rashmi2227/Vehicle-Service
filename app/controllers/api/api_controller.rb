module Api
    class ApiController < ApplicationController
      before_action :doorkeeper_authorize!
      skip_before_action :verify_authenticity_token
      respond_to :json
      before_action :doorkeeper_authorize!
      before_action :current_user

        private def current_user
            @current_user = UserLogin.find_by(id: doorkeeper_token[:resource_owner_id])
        end


      # before_action :current_user
      # helper method to access the current user from the doorkeeper token

    #   def current_user
    #     # p doorkeeper_token
    #     @current_user ||= User.find_by(id: doorkeeper_token[:resource_owner_id]) if doorkeeper_token
    #   end

    end
end