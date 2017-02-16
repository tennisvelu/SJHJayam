class AddFieldInApprovalGradeDetail < ActiveRecord::Migration[5.0]
  def change
  add_column :approval_grade_details, :packing_id, :integer
  end
end
