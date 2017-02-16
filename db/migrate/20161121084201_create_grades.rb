class CreateGrades < ActiveRecord::Migration[5.0]
  def change
    create_table :grades do |t|
      t.string :grade_type
      t.integer :warehouse_id

      t.timestamps
    end
  end
end
