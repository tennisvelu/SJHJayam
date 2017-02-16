class AddFieldImageIdInOutwards < ActiveRecord::Migration[5.0]
  def change
  add_column :outwards, :image_id, :integer
  end
end
