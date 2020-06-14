json.extract! record, :id, :title, :body, :user_id, :price, :cost, :quantity, :created_at, :updated_at
json.url record_url(record, format: :json)
