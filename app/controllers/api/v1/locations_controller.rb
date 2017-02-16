module Api
  module V1
    class LocationsController < ApplicationController
      skip_before_action :verify_authenticity_token
        skip_before_action :check_session
    #  skip_power_check
     # skip_before_filter :authenticate


      respond_to :json

      def index
        respond_with Location.all
      end

      def show
        respond_with Location.find(params[:id])
      end

      def create
        @location_create=Location.create(location_params)
        render json: @location_create
      end

      def update
        respond_with Location.update(location_params)
      end

      def destroy
        respond_with Location.destroy(params[:id])
      end

      private

      def location_params
        params.require(:location).permit!
      end

    end
  end
end