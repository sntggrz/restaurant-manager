json.extract! dish, :id, :restaurant_id, :dish_group, :name, :description, :price, :photo, :created_at, :updated_at
json.url dish_url(dish, format: :json)
