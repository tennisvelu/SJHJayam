class AddFieldOutwardManufactureDetail < ActiveRecord::Migration[5.0]
  def change
   add_column :outward_manufacture_details , :balance ,:integer
   add_column :outward_manufacture_details , :status ,:integer
  end
end
