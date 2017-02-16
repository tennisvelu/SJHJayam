module Api
  module V1
    class InwardManufactureDetailsController < ApplicationController
      skip_before_action :verify_authenticity_token
        skip_before_action :check_session
#      skip_power_check
#      skip_before_filter :authenticate


      respond_to :json

      def index
        respond_with InwardManufactureDetail.all
      end

      def show
        respond_with InwardManufactureDetail.find(params[:id])
      end

      def create
        params.permit!
        inward_manufacture=InwardManufactureDetail.create(params[:inward_manufacture_detail])
        inward_id=inward_manufacture.inward_id
        warehouse_id=Inward.find(inward_id).warehouse_id
        stock=Stock.find_by(:warehouse_id=>warehouse_id,:grade_id=>inward_manufacture.grading,:packing_id=>inward_manufacture.packing)
        book=stock.book_stock+inward_manufacture.quantity
        physical=stock.physical_stock+inward_manufacture.quantity
        stock.update(:book_stock=>book,:physical_stock=>physical)
        render json: inward_manufacture
      end

      def bulk_create
        params.permit!
        count=params["_json"].count
        inward_manufacture=InwardManufactureDetail.create(params["_json"])
        inward_id=inward_manufacture.pluck(:inward_id)[0]
        @warehouse_id=Inward.find(inward_id).warehouse_id
        @grade=inward_manufacture.pluck(:grading,:packing)
        count=@grade.count
        @quantity=inward_manufacture.pluck(:quantity)
        (0..count-1).map do |i|
        stock=Stock.find_by(:warehouse_id=>@warehouse_id,:grade_id=>@grade[i][0],:packing_id=>@grade[i][1])
        book=stock.book_stock+@quantity[i]
        physical=stock.physical_stock+@quantity[i]
        stock.update(:book_stock=>book,:physical_stock=>physical)
        end
       render json: inward_manufacture
      end

      def inward_id
       inward_id=InwardManufactureDetail.where(:inward_id=>params[:inward_id])
       render json: inward_id
      end
      

      def update
        respond_with InwardManufactureDetail.update(inward_manufacture_detail_params)
      end

      def destroy
        respond_with InwardManufactureDetail.destroy(params[:id])
      end

      def inward_manufacture_detail_edit
      params.permit!
      inward_id=params["_json"].pluck(:inward_id)[0]
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
       #img_id=Inward.find(inward_id).image_id
       #Image.where(:id=>img_id).delete_all
       grade_quantity=params["_json"].pluck(:grading,:quantity,:packing)
       @inward_manufacture=InwardManufactureDetail.create(params["_json"])     
       grade_quantity.map do |i|
       stock=Stock.find_by(:grade_id=>i[0],:warehouse_id=>@warehouse_id,:packing_id=>i[2])
       book=stock.book_stock+i[1]
       physical=stock.physical_stock+i[1]
       stock.update(:book_stock=>book,:physical_stock=>physical)     
      end
       render json: @inward_manufacture 
      end  

      private

      def inward_manufacture_detail_params
        params.permit!
       #params.require(:inward_manufacture_detail).permit!
      end
    end
  end
end

