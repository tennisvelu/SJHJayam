class AddFieldInOutward < ActiveRecord::Migration[5.0]
  def change
  add_column :outwards, :party_name, :string
  end
end
