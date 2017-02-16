class AddFieldDamageTable < ActiveRecord::Migration[5.0]
  def change
  add_column :damages ,:total_quantity ,:integer
  add_column :damages, :status, :integer  
  end
end
