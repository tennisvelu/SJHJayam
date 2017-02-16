class CreateWarehouses < ActiveRecord::Migration
  def change
    create_table :warehouses do |t|
      t.string :warehouse_name
      t.integer :contact_id
      t.integer :address_id
      t.integer :company_id
      t.boolean :isactive
      t.integer :created_by
      t.integer :updated_by

      t.timestamps null: false
    end
  end
end
