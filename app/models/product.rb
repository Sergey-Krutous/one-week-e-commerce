class Product < Sluggable
  has_and_belongs_to_many :categories
  has_many :images

  validates :title, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :price, numericality: { greater_than: 0 }
end
