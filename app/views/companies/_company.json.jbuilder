json.extract! company, :id, :company_name, :contact_id, :address_id, :isactive, :created_by, :updated_by, :created_at, :updated_at
json.url company_url(company, format: :json)