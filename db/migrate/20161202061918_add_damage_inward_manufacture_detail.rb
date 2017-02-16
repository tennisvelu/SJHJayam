class AddDamageInwardManufactureDetail < ActiveRecord::Migration[5.0]
#def down
 #   remove_column :inwards,:damage_bags_count
 # end

  def change
    add_column :inward_manufacture_details, :damage_bags_count, :integer
  end 
end
