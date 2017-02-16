module Api
  module V1
    class PackingsController < ApplicationController
        skip_before_action :verify_authenticity_token
        skip_before_action :check_session
#      skip_power_check
#      skip_before_filter :authenticate

      respond_to :json

      def index
        respond_with Packing.all
      end

      def show
        respond_with Packing.find(params[:id])
      end

      def create
        respond_with :api, :v1, Packing.create(packing_params)
      end

      def company_id
        packing=Packing.where(:company_id=>params[:company_id])
        render json: packing
      end  

      def update
        respond_with Packing.update(packing_params)
      end

      def destroy
        respond_with Packing.destroy(params[:id])
      end

      private

      def packing_params
        params.require(:packing).permit!
      end

    end
  end
end


