class CreateOutwardManufactureDetails < ActiveRecord::Migration
  def change
    create_table :outward_manufacture_details do |t|
      t.integer :week_number
      t.integer :quantity
      t.string :grading
      t.string :packing
      t.integer :outward_id
      t.boolean :isactive

      t.timestamps null: false
    end
  end
end
