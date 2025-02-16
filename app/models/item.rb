class Item < ApplicationRecord
  validates :product_code, presence: true, length: { is: 6 }
  validates :name, presence: true, length: { maximum: 255 }
  validates :order_date, presence: true
  validates :order_quantity, presence: true
end