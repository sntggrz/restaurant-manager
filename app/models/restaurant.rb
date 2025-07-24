class Restaurant < ApplicationRecord
  has_many :dishes,  dependent: :destroy
  has_many :orders,  dependent: :destroy
  has_one_attached :logo
end
