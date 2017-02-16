class AddFieldInOutwardManufacture < ActiveRecord::Migration[5.0]
  def change
  add_column :inward_manufacture_details, :damages_count, :float
  end
end
