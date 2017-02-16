class CreateInwardManufactureDetails < ActiveRecord::Migration
  def change
    create_table :inward_manufacture_details do |t|
      t.integer :week_number
      t.integer :quantity
      t.string :grading
      t.string :packing
      t.integer :inward_id
      t.boolean :isactive

      t.timestamps null: false
    end
  end
end
