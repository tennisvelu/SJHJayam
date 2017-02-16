class User < ActiveRecord::Base
  belongs_to :address, :dependent => :destroy
  belongs_to :contact, :dependent => :destroy
  belongs_to :role 
  belongs_to :warehouse
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :contact
  validates_uniqueness_of :user_name
 
end
