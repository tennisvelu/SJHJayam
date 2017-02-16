module Api
  module V1
    class InwardsController < ApplicationController
      skip_before_action :verify_authenticity_token
        skip_before_action :check_session
#      skip_power_check
#      skip_before_filter :authenticate


      respond_to :json

      def index
        respond_with Inward.all
      end

      def show
        respond_with Inward.find(params[:id])
      end

      def create
       inward=Inward.create(inward_params)
       render json: inward
      end
      
      def inward_edit 
      
      inward=Inward.find(params[:id]).update(:truck_number=>params[:truck_number],:invoice_number=>params[:invoice_number])
      render json:inward
      end
      
      def warehouse_identification
        @warehouse_id_api=Inward.where(:warehouse_id=>params[:format].to_i)
        render json: @warehouse_id_api
      end 
      
      def inward_identification
        @inward_id_api=InwardManufactureDetail.where(:inward_id=>params[:format].to_i)
        render json: @inward_id_api
      end 
      
      def update
        @total=Inward.find(params[:id]).update(:total_quantity=>params[:total_quantity])
        render json:@total
      end
      
      def total_quantity_update
        @total=Inward.find(params[:id]).update(:total_quantity=>params[:total_quantity],:warehouse_id=>params[:warehouse_id],:image_id=>params[:image_id])
        render json:@total
        end 


      def date_report
        params.permit!
      to=Date.parse(params[:created_at])+1
      date=Inward.where(:created_at=>(params[:created_at])..(to.strftime("%Y-%m-%d")))
      render json: date
      end   
     
      def destroy
        respond_with Inward.destroy(params[:id])
      end

      def inward_delete
      params.permit!
      inward_id=params[:id]
      if Inward.where(:id=>inward_id).present?
       @warehouse_id=Inward.find(inward_id).warehouse_id
       grade_id=Inward.find(inward_id).inward_manufacture_details.pluck(:grading,:quantity,:packing)
       grade_id.map do |i|
       stock=Stock.find_by(:grade_id=>i[0],:warehouse_id=>@warehouse_id,:packing_id=>i[2])
       book=stock.book_stock-i[1]
       physical=stock.physical_stock-i[1]
       stock.update(:book_stock=>book,:physical_stock=>physical)     
      end
       inward_manu_id=InwardManufactureDetail.where(:inward_id=>inward_id).ids
       if Damage.where(:warehouse_id=>@warehouse_id).last.present?
       damage_total_quantity1=Damage.where(:warehouse_id=>@warehouse_id).last.total_quantity
       damage_count=Damage.where(:inward_manufacture_id=>inward_manu_id).pluck(:bags_count).sum
       Damage.where(:inward_manufacture_id=>inward_manu_id).delete_all
       if Damage.where(:warehouse_id=>@warehouse_id).last.present?
        damage_total_quantity2=Damage.where(:warehouse_id=>@warehouse_id).last.total_quantity
       if damage_total_quantity1==damage_total_quantity2
         quantity=damage_total_quantity2-damage_count
         Damage.where(:warehouse_id=>@warehouse_id).last.update(:total_quantity=>quantity)
       end 
     end
     end
       InwardManufactureDetail.where(:id=>inward_manu_id).delete_all
       inward_detail=Inward.find(inward_id)
       img_id=inward_detail.image_id
       Image.where(:id=>img_id).delete_all
       inward_detail.delete
        render json: "true"
      else
         render json: "false"
      end   
      
    end 

    def image_path
byebug
    end 



      private

      def inward_params
        params.require(:inward).permit!
      end

    end
  end
end

