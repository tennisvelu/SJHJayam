class AddFieldImageIdInInwards < ActiveRecord::Migration[5.0]
  def change
  add_column :inwards, :image_id, :integer
  end
end
