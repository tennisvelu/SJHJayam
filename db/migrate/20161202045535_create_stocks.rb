class CreateStocks < ActiveRecord::Migration[5.0]
  def change
    create_table :stocks do |t|
      t.integer :grade_id
      t.integer :book_stock
      t.integer :physical_stock
      t.integer :warehouse_id

      t.timestamps
    end
  end
end
