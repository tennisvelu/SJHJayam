class AddFieldInDamage < ActiveRecord::Migration[5.0]
  def change
  add_column :damages, :inward_manufacture_id, :integer
  end
end
