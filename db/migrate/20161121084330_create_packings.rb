class CreatePackings < ActiveRecord::Migration[5.0]
  def change
    create_table :packings do |t|
      t.string :packing_type
      t.integer :warehouse_id

      t.timestamps
    end
  end
end
