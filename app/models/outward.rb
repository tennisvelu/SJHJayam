class Outward < ActiveRecord::Base
	has_many :outward_manufacture_details, :dependent => :destroy
	has_one :outward_approval
	belongs_to :warehouse
	belongs_to :image
end
