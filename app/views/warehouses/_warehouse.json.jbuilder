json.extract! warehouse, :id, :warehouse_name, :contact_id, :address_id, :company_id, :isactive, :created_by, :updated_by, :created_at, :updated_at
json.url warehouse_url(warehouse, format: :json)