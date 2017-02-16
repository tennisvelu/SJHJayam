module Api
  module V1
    class GradePackingsController < ApplicationController
      skip_before_action :verify_authenticity_token
      skip_before_action :check_session
    #  skip_power_check
     # skip_before_filter :authenticate


      respond_to :json

      def index
        respond_with GradePacking.all
      end

      def show
        respond_with GradePacking.find(params[:id])
      end

      def create
        respond_with :api, :v1, GradePacking.create(grade_packing_params)
      end

      def update
        respond_with GradePacking.update(grade_packing_params)
      end

      def destroy
        respond_with GradePacking.destroy(params[:id])
      end

      def grade_id
       packing_id=GradePacking.where(:grade_id=>params[:id]).pluck(:packing_id)
       pack=Packing.where(:id=>packing_id)
       render json: pack
      end	

      private

      def grade_packing_params
        params.require(:grade_packing).permit!
      end

    end
  end
end
