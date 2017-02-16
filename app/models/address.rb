class Address < ActiveRecord::Base
has_one :user
has_one :company
has_one :warehouse
end
