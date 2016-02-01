class Order < ActiveRecord::Base
  belongs_to :billing_address, class_name: "Address", validate: true
  belongs_to :shipping_address, class_name: "Address", validate: true
  validates :billing_address, :shipping_address, presence: true
  has_many :order_lines, validate: true
end