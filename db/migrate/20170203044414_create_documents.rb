class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.string :document_name
      t.integer :image_id
      t.integer :warehouse_id

      t.timestamps
    end
  end
end
