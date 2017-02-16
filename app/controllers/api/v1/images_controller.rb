module Api
  module V1
    class ImagesController < ApplicationController
        skip_before_action :verify_authenticity_token
        skip_before_action :check_session
#      skip_power_check
#      skip_before_filter :authenticate

      respond_to :json

      def index
        respond_with Image.all
      end

      def show
        respond_with Image.find(params[:id])
      end

      def create

        path = "#{Rails.root}/public/temp_fol/temp1_file.png"
        img_binary = params[:image_path]
        File.open(path,"wb"){|pp| pp.write Base64.decode64(img_binary) }
        data = Image.create(:image_path=>File.open(path, "rb"))
        FileUtils.rm(path)
        render json: data.id

      end
      
      def image_id
      image_path = {"image_path":Image.find(params[:id]).image_path.url}
      
      render json: image_path
      end      

      def update
        respond_with Image.update(image_params)
      end

      def destroy
        respond_with Image.destroy(params[:id])
      end

      private

      def image_params
        params.require(:image).permit!
      end

    end
  end
end
