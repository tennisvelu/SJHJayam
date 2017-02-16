module Api
  module V1
    class DamagesController < ApplicationController
        skip_before_action :verify_authenticity_token
        skip_before_action :check_session
#      skip_power_check
#      skip_before_filter :authenticate

      respond_to :json

      def index
        respond_with Damage.all
      end

      def show
        respond_with Damage.find(params[:id])
      end

      def damage_stock
      damage=Damage.where(:warehouse_id=>params[:warehouse_id])
      unless damage.empty?
      @total=damage.last.total_quantity
      end
      render json: @total
      end

      def create
        params.permit!
       unless params[:damage][:bags_count]==0
       if Damage.where(:warehouse_id=>params[:damage][:warehouse_id]).empty?
        @damage= Damage.create(params[:damage])
        @damage.update(:total_quantity=>@damage.bags_count)
       else
        quantity=Damage.where(:warehouse_id=>params[:damage][:warehouse_id]).last.total_quantity
        @damage= Damage.create(params[:damage]) 
        total=quantity+@damage.bags_count
        @damage.update(:total_quantity=>total)
       end
       end
       render json: @damage
      end

      def bulk_create
        params.permit!
        @warehouse_id=params["_json"].pluck(:warehouse_id)[0]
        count=params["_json"].count
       (0..count-1).map do |i|
       unless params["_json"][i][:bags_count] == 0
        if Damage.where(:warehouse_id=>@warehouse_id).empty?
         @damage= Damage.create(params["_json"][i])
         @damage.update(:total_quantity=>@damage.bags_count)
        else
         quantity=Damage.where(:warehouse_id=>@warehouse_id).last.total_quantity
         @damage= Damage.create(params["_json"][i]) 
         total=quantity+@damage.bags_count
         @damage.update(:total_quantity=>total)
        end
        end
       end
      render json: "true"
      end

      def update
        respond_with Damage.update(damage_params)
      end

      def destroy
        respond_with Damage.destroy(params[:id])
      end

      private

      def damage_params
        params.permit!
        #params.require(:damage).permit!
      end

    end
  end
end


