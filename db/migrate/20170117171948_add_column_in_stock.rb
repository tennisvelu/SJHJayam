class AddColumnInStock < ActiveRecord::Migration[5.0]
  def change
  add_column :stocks, :packing_id, :integer
  end
end
