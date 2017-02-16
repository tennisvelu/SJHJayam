class AddFieldInOutwardApprovalTable < ActiveRecord::Migration[5.0]
  def change
  add_column :outward_approvals,:total_balance,:integer
  end
end
