module Api
  module V1
    class StocksController < ApplicationController
skip_before_action :verify_authenticity_token
        skip_before_action :check_session
#      skip_power_check
#      skip_before_filter :authenticate

      respond_to :json

      def index
        respond_with Stock.all
      end

      def show
        respond_with Stock.find(params[:id])
      end

      def create
        respond_with :api, :v1, Stock.create(stock_params)
      end

     def warehouse_stock
       stock=Stock.where(:warehouse_id=>params[:warehouse_id])
       render json: stock
      end

      def update
        respond_with Stock.update(stock_params)
      end

      def destroy
        respond_with Stock.destroy(params[:id])
      end
    
      def grade_packing_id
        stock=Stock.find_by(:grade_id=>params[:grade_id],:packing_id=>params[:packing_id],:warehouse_id=>params[:warehouse_id])
        render json: stock
       end 

      private

      def stock_params
        params.require(:stock).permit!
      end

    end
  end
end

