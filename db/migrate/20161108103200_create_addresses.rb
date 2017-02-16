class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address1
      t.string :post_code
      t.string :city
      t.string :state
      t.string :country

      t.timestamps null: false
    end
  end
end
