module Api
  module V1
    class WarehousesController < ApplicationController
      skip_before_action :verify_authenticity_token
        skip_before_action :check_session
 #     skip_power_check
  #    skip_before_filter :authenticate


      respond_to :json

      def index
        respond_with Warehouse.all
      end

      def show
        respond_with Warehouse.find(params[:id])
      end

      def create
        respond_with :api, :v1, Warehouse.create(warehouse_params)
      end

      def update
        respond_with Warehouse.update(warehouse_params)
      end

      def destroy
        respond_with Warehouse.destroy(params[:id])
      end

      private

      def warehouse_params
        params.require(:warehouse).permit!
      end

    end
  end
end

