class Item < ApplicationRecord
  belongs_to :order
  belongs_to :dish
  before_validation :snapshot_price
  def snapshot_price
    self.price ||= dish.price
  end
end
