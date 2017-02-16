class AddFieldInInward < ActiveRecord::Migration[5.0]
  def change
add_column :inwards , :rail_status ,:boolean
  end
end
