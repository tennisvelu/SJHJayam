class RemoveFieldInOutwardManufactureDetailTable < ActiveRecord::Migration[5.0]
  def change
  remove_column :outward_manufacture_details ,:balance
  remove_column :outward_manufacture_details ,:status
  end
end
