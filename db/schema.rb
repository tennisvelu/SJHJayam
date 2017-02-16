# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170203082518) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "address1"
    t.string   "post_code"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "approval_grade_details", force: :cascade do |t|
    t.integer  "grade_id"
    t.integer  "quantity"
    t.integer  "outward_approval_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "balance"
    t.integer  "packing_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string   "company_name"
    t.integer  "contact_id"
    t.integer  "address_id"
    t.boolean  "isactive"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "email"
    t.string   "telephone_number"
    t.string   "mobile_number"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "damages", force: :cascade do |t|
    t.date     "damage_entry_date"
    t.integer  "grade"
    t.integer  "bags_count"
    t.integer  "warehouse_id"
    t.boolean  "isactive"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "total_quantity"
    t.integer  "status"
    t.integer  "inward_manufacture_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string   "document_name"
    t.integer  "image_id"
    t.integer  "warehouse_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "grade_packings", force: :cascade do |t|
    t.integer  "grade_id"
    t.integer  "packing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "grades", force: :cascade do |t|
    t.string   "grade_type"
    t.integer  "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.string   "image_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inward_manufacture_details", force: :cascade do |t|
    t.integer  "week_number"
    t.integer  "quantity"
    t.string   "grading"
    t.string   "packing"
    t.integer  "inward_id"
    t.boolean  "isactive"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.float    "damages_count"
  end

  create_table "inwards", force: :cascade do |t|
    t.string   "truck_number"
    t.string   "invoice_number"
    t.datetime "invoice_date"
    t.boolean  "return"
    t.integer  "total_quantity"
    t.integer  "warehouse_id"
    t.boolean  "isactive"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.boolean  "rail_status"
    t.integer  "image_id"
  end

  create_table "loading_types", force: :cascade do |t|
    t.string   "type_of_loading"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "location_name"
    t.integer  "status"
    t.integer  "warehouse_id"
    t.boolean  "isactive"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "outward_approvals", force: :cascade do |t|
    t.string   "party_name"
    t.string   "total_quantity"
    t.string   "dispatch_place"
    t.string   "billing_type"
    t.datetime "billing_date"
    t.integer  "status"
    t.integer  "outward_id"
    t.integer  "warehouse_id"
    t.boolean  "isactive"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "total_balance"
  end

  create_table "outward_manufacture_details", force: :cascade do |t|
    t.integer  "week_number"
    t.integer  "quantity"
    t.string   "grading"
    t.string   "packing"
    t.integer  "outward_id"
    t.boolean  "isactive"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "outwards", force: :cascade do |t|
    t.string   "truck_number"
    t.string   "invoice_number"
    t.datetime "invoice_date"
    t.integer  "location_id"
    t.integer  "dispatch_type"
    t.integer  "type_of_load"
    t.integer  "total_quantity"
    t.integer  "payment_type"
    t.integer  "warehouse_id"
    t.boolean  "isactive"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "status"
    t.string   "party_name"
    t.integer  "image_id"
  end

  create_table "packings", force: :cascade do |t|
    t.string   "packing_type"
    t.integer  "company_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "role_type"
    t.boolean  "isactive"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stocks", force: :cascade do |t|
    t.integer  "grade_id"
    t.integer  "book_stock"
    t.integer  "physical_stock"
    t.integer  "warehouse_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "packing_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "user_name"
    t.string   "password"
    t.integer  "role_id"
    t.integer  "contact_id"
    t.integer  "address_id"
    t.integer  "warehouse_id"
    t.boolean  "isactive"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "warehouses", force: :cascade do |t|
    t.string   "warehouse_name"
    t.integer  "contact_id"
    t.integer  "address_id"
    t.integer  "company_id"
    t.boolean  "isactive"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

end
