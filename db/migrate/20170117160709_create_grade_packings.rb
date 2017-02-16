class CreateGradePackings < ActiveRecord::Migration[5.0]
  def change
    create_table :grade_packings do |t|
      t.integer :grade_id
      t.integer :packing_id

      t.timestamps
    end
  end
end
