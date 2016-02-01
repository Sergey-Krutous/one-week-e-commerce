class OrderLine < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  
  validates :order, :product, :quantity, :price, presence: true
  validates :quantity, numericality: { greater_than: 0 }
  validates :price, numericality: { greater_than: 0 }
end
