class CreateInwards < ActiveRecord::Migration
  def change
    create_table :inwards do |t|
      t.string :truck_number
      t.integer :invoice_number
      t.datetime :invoice_date
      t.integer :damage_bags_count
      t.boolean :return
      t.integer :total_quantity
      t.integer :warehouse_id
      t.boolean :isactive
      t.integer :created_by
      t.integer :updated_by

      t.timestamps null: false
    end
  end
end
