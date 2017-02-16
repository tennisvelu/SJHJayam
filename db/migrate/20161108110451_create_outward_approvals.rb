class CreateOutwardApprovals < ActiveRecord::Migration
  def change
    create_table :outward_approvals do |t|
      t.string :party_name
      t.string :total_quantity
      t.string :dispatch_place
      t.string :billing_type
      t.datetime :billing_date
      t.integer :status
      t.integer :outward_id
      t.integer :warehouse_id
      t.boolean :isactive
      t.timestamps null: false
    end
  end
end
