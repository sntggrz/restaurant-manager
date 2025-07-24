json.extract! order, :id, :restaurant_id, :date, :subtotal, :taxes, :total, :created_at, :updated_at
json.url order_url(order, format: :json)
