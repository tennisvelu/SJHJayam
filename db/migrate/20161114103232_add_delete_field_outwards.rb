class AddDeleteFieldOutwards < ActiveRecord::Migration[5.0]
  def change
 add_column :outwards , :status ,:string
  end
end
