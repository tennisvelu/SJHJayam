class Inward < ActiveRecord::Base
	has_many :inward_manufacture_details, :dependent => :destroy
	belongs_to :warehouse
	belongs_to :image
end
