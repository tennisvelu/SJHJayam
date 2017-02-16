class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :email
      t.string:telephone_number
      t.string :mobile_number

      t.timestamps null: false
    end
  end
end
