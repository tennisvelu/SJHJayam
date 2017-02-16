class AddFieldInApprovalGradeTable < ActiveRecord::Migration[5.0]
  def change
  add_column :approval_grade_details ,:balance,:integer
  end
end
