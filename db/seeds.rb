# db/seeds.rb
require "faker"

puts "🌪️  Cleaning DB…"
Item.destroy_all
Order.destroy_all
Dish.destroy_all
Restaurant.destroy_all

GROUPS = [ "Entrees", "Soups & Salads", "Desserts", "Drinks" ].freeze

def random_price(min: 5.0, max: 50.0)
  rand((min * 100).to_i..(max * 100).to_i) / 100.0
end

def random_phone
  Faker::PhoneNumber.cell_phone_in_e164
end

puts "🏨  Creating 4 Restaurants…"
restaurants = 4.times.map do
  Restaurant.create!(
    name:        Faker::Restaurant.name,
    description: Faker::Restaurant.description,
    address:     Faker::Address.full_address,
    phone:       random_phone,
    logo:        Faker::LoremFlickr.image(size: "100x100", search_terms: [ 'restaurant' ])
  )
end

puts "🍽  Creating 5 Dishes in each group (20 per restaurant)…"
restaurants.each do |rest|
  GROUPS.each do |group|
    5.times do
      rest.dishes.create!(
        dish_group:  group,
        name:        Faker::Food.dish,
        description: Faker::Food.description,
        price:       random_price(min: 10.0, max: 100.0),
        photo:       Faker::LoremFlickr.image(size: "200x200", search_terms: [ 'food' ])
      )
    end
  end
end

puts "🧾  Generating Orders & Items…"
restaurants.each do |rest|
  rand(5..10).times do
    order = rest.orders.create!(
      date: Faker::Date.backward(days: 30)
    )

    subtotal_amount = 0.0

    # pick 1–5 dishes this order
    rest.dishes.sample(rand(1..5)).each do |dish|
      qty = rand(1..3)
      qty.times do
        order.items.create!(dish: dish, price: dish.price)
        subtotal_amount += dish.price
      end
    end

    taxes_amount = (subtotal_amount * 0.10).round(2)
    total_amount = (subtotal_amount + taxes_amount).round(2)

    order.update!(
      subtotal: subtotal_amount,   # <— use `subtotal` not `sub_total`
      taxes:    taxes_amount,
      total:    total_amount
    )
  end
end

puts "✅  db:seed complete!"
