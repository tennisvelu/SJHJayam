module Api
  module V1
    class OutwardsController < ApplicationController
        skip_before_action :verify_authenticity_token
        skip_before_action :check_session
#      skip_power_check
#      skip_before_filter :authenticate


      respond_to :json

      def index
        respond_with Outward.all
      end

      def show
        respond_with Outward.find(params[:id])
      end

      def create
        
        respond_with :api, :v1, Outward.create(outward_params)
      end

      def update
        respond_with Outward.update(outward_params)
      end

      def destroy
        respond_with Outward.destroy(params[:id])
      end

      def outward_update
       total=Outward.find(params[:id]).update(:truck_number=>params[:truck_number],:invoice_date=>params[:invoice_date],:invoice_number=>params[:invoice_number],:type_of_load=>params[:type_of_load],:status=>params[:status])
       render json: total
      end

      def status_update
        status=Outward.find(params[:id]).update(:status=>params[:status])
        render json: status
      end       

      def total_quantity_update
        @total=Outward.find(params[:id]).update(:total_quantity=>params[:total_quantity],:warehouse_id=>params[:warehouse_id],:image_id=>params[:image_id])
        render json: @total
      end 

      def outward_edit
        a=outward_params
        Outward.find(a[:id]).update(:invoice_number=>a[:invoice_number],:truck_number=>a[:truck_number],:invoice_date=>a[:invoice_date],:location_id=>a[:location_id],:type_of_load=>a[:type_of_load],:payment_type=>a[:payment_type],:dispatch_type=>a[:dispatch_type])
      end 

      def date_report
      to=Date.parse(params[:created_at])+1
      date=Outward.where(:created_at=>params[:created_at]..to.strftime("%Y-%m-%d"))
      render json: date
      end 


      def outward_delete
         params.permit!
         @outward_id=params[:id]
      if Outward.where(:id=>@outward_id).present?
         @warehouse_id=Outward.find(@outward_id).warehouse_id
         @payment=Outward.find(@outward_id).payment_type
      if @payment == 0
         grade_id=Outward.find(@outward_id).outward_manufacture_details.pluck(:grading,:quantity,:packing)
         grade_id.map do |i|
         stock=Stock.find_by(:grade_id=>i[0],:warehouse_id=>@warehouse_id,:packing_id=>i[2]) 
         book=stock.book_stock+i[1]
         physical=stock.physical_stock+i[1]
         stock.update(:book_stock=>book,:physical_stock=>physical)     
      end
         
      elsif @payment == 1
       grade_id=Outward.find(@outward_id).outward_manufacture_details.pluck(:grading,:quantity,:packing)
       grade_id.map do |i|
       stock=Stock.find_by(:grade_id=>i[0],:warehouse_id=>@warehouse_id,:packing_id=>i[2]) 
       book=stock.book_stock+i[1]
       stock.update(:book_stock=>book)     
      end
     
     elsif @payment == 2
       grade_id=Outward.find(@outward_id).outward_manufacture_details.pluck(:grading,:quantity,:packing)
       grade_id.map do |i|
       stock=Stock.find_by(:grade_id=>i[0],:warehouse_id=>@warehouse_id,:packing_id=>i[2]) 
       physical=stock.physical_stock+i[1]
       stock.update(:physical_stock=>physical)     
      end
     end
       OutwardManufactureDetail.where(:outward_id=>@outward_id).delete_all
       imgg=Outward.where(:id=>@outward_id).pluck(:image_id)[0] 
       Image.where(:id=>imgg).delete_all
       Outward.find(@outward_id).delete
    
      render json: "true" 
    else
      render json: "false"
    end
    end

      private

      def outward_params
        params.require(:outward).permit!
      end

    end
  end
end
