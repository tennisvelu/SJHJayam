class CreateOutwards < ActiveRecord::Migration
  def change
    create_table :outwards do |t|
      t.string :truck_number
      t.integer :invoice_number
      t.datetime :invoice_date
      t.integer :location_id
      t.integer :dispatch_type
      t.integer :type_of_load
      t.integer :total_quantity
      t.integer :payment_type
      t.integer :warehouse_id
      t.boolean :isactive
      t.integer :created_by
      t.integer :updated_by

      t.timestamps null: false
    end
  end
end
