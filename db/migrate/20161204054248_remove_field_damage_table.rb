class RemoveFieldDamageTable < ActiveRecord::Migration[5.0]
  def change
  remove_column :damages,:week_no
  end
end
