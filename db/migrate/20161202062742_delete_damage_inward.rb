class DeleteDamageInward < ActiveRecord::Migration[5.0]
  def change
  remove_column :inwards,:damage_bags_count
  end
end
