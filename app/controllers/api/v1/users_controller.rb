module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :verify_authenticity_token
      skip_before_action :check_session
     # skip_power_check
      #skip_before_filter :authenticate


      respond_to :json

      def index
        respond_with User.all
      end

      def show
        respond_with User.find(params[:id])
      end

      def create
        respond_with :api, :v1, User.create(User_params)
      end

      def update
        respond_with User.update(User_params)
      end

      def destroy
        respond_with User.destroy(params[:id])
      end

      def application_login
        @validate=User.where(:user_name=>params[:user_name],:password=>params[:password])
        @id="null"
         unless @validate.empty?
           render json: @validate
         else
          render json: @id
         end 
      end

      private

      def User_params
        params.require(:user).permit!
      end

    end
  end
end

