class ChangeDatatypeInOutwards < ActiveRecord::Migration[5.0]
def self.up
    change_column :outwards ,:invoice_number, :string
  end
 
  def self.down
    change_column :outwards, :invoice_number, :integer
  end
end
