class ChangeFieldPackingTable < ActiveRecord::Migration[5.0]
  def change
  rename_column :packings ,:warehouse_id ,:company_id
  end
end
