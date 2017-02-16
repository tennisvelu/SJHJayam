class CreateApprovalGradeDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :approval_grade_details do |t|
      t.integer :grade_id
      t.integer :quantity
      t.integer :outward_approval_id

      t.timestamps
    end
  end
end
