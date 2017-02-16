class CreateLoadingTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :loading_types do |t|
      t.string :type_of_loading

      t.timestamps
    end
  end
end
