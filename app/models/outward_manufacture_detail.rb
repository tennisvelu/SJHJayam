class OutwardManufactureDetail < ActiveRecord::Base
	belongs_to :outward
    #accepts_nested_attributes_for :outward
end
