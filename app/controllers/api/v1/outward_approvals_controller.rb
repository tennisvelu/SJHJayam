module Api
  module V1
    class OutwardApprovalsController < ApplicationController
      skip_before_action :verify_authenticity_token
      skip_before_action :check_session
    #  skip_power_check
     # skip_before_filter :authenticate


      respond_to :json

      def index
        respond_with OutwardApproval.all
      end

      def show
        respond_with OutwardApproval.find(params[:id])
      end

      def create
        respond_with :api, :v1, OutwardApproval.create(outward_approval_params)
      end

      def update
        respond_with OutwardApproval.update(outward_approval_params)
      end

      def billing_date_update
        bill=OutwardApproval.find_by(:outward_id=>params[:outward_id]).update(:billing_date=>params[:billing_date],:status=>params[:status])
        render json: bill 
      end
      
      def outward_approval_total_update
        @outward_id=OutwardApproval.find(params[:id]).update(:total_quantity=>params[:total_quantity],:total_balance=>params[:total_balance],:status=>params[:status])
        render json: @outward_id 
      end

      def outward_approval_status_update
        
        status_update=OutwardApproval.find(params[:id]).update(:status=>params[:status])
        outward_approval=OutwardApproval.find(params[:id])
        bill_type=outward_approval.billing_type
        status=outward_approval.status
        @warehouse_id=outward_approval.warehouse_id
        grade_quantity=ApprovalGradeDetail.where(:outward_approval_id=>params[:id]).pluck(:grade_id,:quantity,:packing_id)
        if bill_type=="1" && status==4
          grade_quantity.map do |i| 
          stock=Stock.find_by(:grade_id=>i[0],:warehouse_id=>@warehouse_id,:packing_id=>i[2])
          book=stock.book_stock-i[1]
          stock.update(:book_stock=>book)
         end
        elsif bill_type=="2" && status==3
          grade_quantity.map do |i| 
          stock=Stock.find_by(:grade_id=>i[0],:warehouse_id=>@warehouse_id,:packing_id=>i[2])
          physical=stock.physical_stock-i[1]
          stock.update(:physical_stock=>physical)
         end
        end
        render json: status_update
      end  
    
      def destroy
        respond_with OutwardApproval.destroy(params[:id])
      end

      private

      def outward_approval_params
        params.require(:outward_approval).permit!
      end

    end
  end
end
