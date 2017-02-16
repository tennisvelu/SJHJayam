class RenameGradeTable < ActiveRecord::Migration[5.0]
  def change
  rename_column :grades, :warehouse_id, :company_id
  end
end
