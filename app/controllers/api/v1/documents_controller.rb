module Api
  module V1
    class DocumentsController < ApplicationController
           skip_before_action :verify_authenticity_token
        skip_before_action :check_session
#      skip_power_check
#      skip_before_filter :authenticate


      respond_to :json

      def index
        respond_with Document.all
      end

      def show
        respond_with Document.find(params[:id])
      end

      def create
        respond_with :api, :v1, Document.create(document_params)
      end

      def update
        respond_with Document.update(document_params)
      end

      def destroy
        respond_with Document.destroy(params[:id])
      end

      private

      def document_params
        params.require(:document).permit!
      end

    end
  end
end
