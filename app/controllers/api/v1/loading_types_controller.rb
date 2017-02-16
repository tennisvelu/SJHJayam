module Api
  module V1
    class LoadingTypesController < ApplicationController
        skip_before_action :verify_authenticity_token
        skip_before_action :check_session
#      skip_power_check
#      skip_before_filter :authenticate

      respond_to :json

      def index
        respond_with LoadingType.all
      end

      def show
        respond_with LoadingType.find(params[:id])
      end

      def create
        respond_with :api, :v1, LoadingType.create(loading_type_params)
      end

      def update
        respond_with LoadingType.update(loading_type_params)
      end

      def destroy
        respond_with LoadingType.destroy(params[:id])
      end

      private

      def loading_type_params
        params.require(:loading_type).permit!
      end

    end
  end
end


