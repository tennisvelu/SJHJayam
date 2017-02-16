module Api
  module V1
    class ApprovalGradeDetailsController < ApplicationController
     skip_before_action :verify_authenticity_token
        skip_before_action :check_session
#      skip_power_check
#      skip_before_filter :authenticate

      respond_to :json

      def index
        respond_with ApprovalGradeDetail.all
      end

      def show
        respond_with ApprovalGradeDetail.find(params[:id])
      end

      def create
      params.permit!
        data=ApprovalGradeDetail.create(params["_json"])
        render json: data
      end

      def update
        respond_with ApprovalGradeDetail.update(approval_grade_detail_params)
      end

      def approval_id
      approval=ApprovalGradeDetail.where(:outward_approval_id=>params[:outward_approval_id])
      render json: approval
      end  

     def destroy
        respond_with ApprovalGradeDetail.destroy(params[:id])
      end

      def balance_update
      count=params["_json"].count
      outward_approval_id=ApprovalGradeDetail.find(params["_json"][0][:id]).outward_approval_id
      @warehouse_id=OutwardApproval.find(outward_approval_id).warehouse_id
     (0..count-1).map do |i|
      data=params["_json"][i]
      approval_id=ApprovalGradeDetail.find(data[:id])
      balance=approval_id.balance-data[:balance]
      approval_id.update(:grade_id=>data[:grade_id],:balance=>data[:balance],:packing_id=>data[:packing_id])
      stock=Stock.find_by(:grade_id=>data[:grade_id],:warehouse_id=>@warehouse_id,:packing_id=>data[:packing_id])
      book=stock.book_stock-balance
      stock.update(:book_stock=>book)
      end
       approval=ApprovalGradeDetail.where(:outward_approval_id=>outward_approval_id)
       render json: approval
      end 

      def advance_dispatch
      count=params["_json"].count
      outward_approval_id=ApprovalGradeDetail.find(params["_json"][0][:id]).outward_approval_id
      @warehouse_id=OutwardApproval.find(outward_approval_id).warehouse_id
     (0..count-1).map do |i|
      data=params["_json"][i]
      approval_id=ApprovalGradeDetail.find(data[:id])
      balance=approval_id.balance-data[:balance]
      approval_id.update(:grade_id=>data[:grade_id],:balance=>data[:balance],:packing_id=>data[:packing_id])
      stock=Stock.find_by(:grade_id=>data[:grade_id],:warehouse_id=>@warehouse_id,:packing_id=>data[:packing_id])
      physical=stock.physical_stock-balance
      stock.update(:physical_stock=>physical)
      end
       approval=ApprovalGradeDetail.where(:outward_approval_id=>outward_approval_id)
       render json: approval
      end  


      private

      def approval_grade_detail_params
        params.permit!
        #params.require(:approval_grade_detail).permit!
      end

    end
  end
end

