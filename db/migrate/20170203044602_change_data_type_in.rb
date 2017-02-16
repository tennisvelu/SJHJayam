class ChangeDataTypeIn < ActiveRecord::Migration[5.0]
def self.up
    change_column :inwards ,:invoice_number, :string
  end
 
  def self.down
    change_column :inwards, :invoice_number, :integer
  end
end
