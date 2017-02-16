module Api
  module V1
    class RolesController < ApplicationController
      skip_before_action :verify_authenticity_token
        skip_before_action :check_session
#      skip_power_check
#      skip_before_filter :authenticate


      respond_to :json

      def index
        respond_with Role.all
      end

      def show
        respond_with Role.find(params[:id])
      end

      def create
        respond_with :api, :v1, Role.create(role_params)
      end

      def update
        respond_with Role.update(role_params)
      end

      def destroy
        respond_with Role.destroy(params[:id])
      end

      private

      def role_params
        params.require(:role).permit!
      end

    end
  end
end
