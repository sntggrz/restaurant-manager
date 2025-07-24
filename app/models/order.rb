# app/models/order.rb
class Order < ApplicationRecord
  belongs_to :restaurant
  has_many :items, dependent: :destroy
  accepts_nested_attributes_for :items,
    allow_destroy: true,
    reject_if: ->(attrs) { attrs["dish_id"].blank? || attrs["quantity"].blank? }

  before_validation :calc_totals

  private
  def calc_totals
    self.subtotal = items.sum { |i| i.quantity.to_i * i.price.to_f }
    self.taxes    = subtotal * 0.10
    self.total    = subtotal + taxes
  end
end
