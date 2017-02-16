class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :location_name
      t.integer :status
      t.integer :warehouse_id
      t.boolean :isactive

      t.timestamps null: false
    end
  end
end
