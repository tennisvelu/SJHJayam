class InwardManufactureDetail < ActiveRecord::Base
  belongs_to :inward 
  #accepts_nested_attributes_for :inward
end
