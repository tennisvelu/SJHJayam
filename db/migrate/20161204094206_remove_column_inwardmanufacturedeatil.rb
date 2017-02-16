class RemoveColumnInwardmanufacturedeatil < ActiveRecord::Migration[5.0]
  def change
  remove_column :inward_manufacture_details , :damage_bags_count
  end
end
