class BasketItem
  attr_reader :product_id
  attr_reader :quantity
  attr_reader :price
  
  def price= (value)
    digits = value.is_a?(Float) ? [Math.log10(value).ceil + 2, 2].max : 0
    @price = BigDecimal.new(value, digits)
  end
  
  def product_id= (value)
    @product_id = value.to_i
  end
  
  def quantity= (value)
    @quantity = value.to_i
  end

  def initialize serialized = nil
    return unless serialized
    serialized = serialized.with_indifferent_access
    [:product_id, :quantity, :price].each do |key|
      self.public_send "#{key}=", serialized[key]
    end
  end
  
  def serialize
    hash = HashWithIndifferentAccess.new
    [:product_id, :quantity, :price].each do |key|
      hash[key] = self.instance_variable_get("@#{key}")  
    end
    hash
  end
  
  def product
    @product ||= Product.find(@product_id)
  end
end