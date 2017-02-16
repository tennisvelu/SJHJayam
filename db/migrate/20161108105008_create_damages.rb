class CreateDamages < ActiveRecord::Migration
  def change
    create_table :damages do |t|
      t.date :damage_entry_date
      t.integer :week_no
      t.integer :grade
      t.integer :bags_count
      t.integer :warehouse_id
      t.boolean :isactive
      t.integer :created_by
      t.integer :updated_by

      t.timestamps null: false
    end
  end
end
