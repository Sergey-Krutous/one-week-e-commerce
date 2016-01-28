class Basket
  UNSUFFICIENT_STOCK_ERROR_MESSAGE = "the item cannot be added to your basket because the product has unsufficient stock"

  attr_accessor :items
  attr_accessor :error_message

  def initialize serialized=nil
    @items = []
    return unless serialized 
    serialized = serialized.with_indifferent_access
    if serialized[:items] then
      serialized[:items].each do |hash|
        better_hash = hash.with_indifferent_access
        add_item better_hash[:product_id], better_hash[:quantity], better_hash[:price]
      end
    end
  end
  
  def serialize
    {items: @items.collect {|item| item.serialize}}.with_indifferent_access
  end
  
  def add_item product_id, quantity, price
    product = Product.find_by_id(product_id)
    return self unless product
    
    item = @items.find { |i| i.product_id == product_id.to_i }
    
    @error_message = UNSUFFICIENT_STOCK_ERROR_MESSAGE and return self unless can_add_to_item? item, product, quantity
    
    if item.nil?
      item = BasketItem.new
      item.product_id = product_id
      item.quantity = 0
      @items << item
    end
    item.quantity += quantity
    item.price = price
    self
  end
  
  def can_add_to_item? item, product, quantity
    (item ? item.quantity : 0) + quantity <= product.quantity
  end
  
  def delete_item product_id
    @items.delete_if { |item| item.product_id == product_id.to_i }
    self
  end
  
  def item_count
    items.sum(&:quantity)
  end
  
  def total
    items.inject(0){|sum,item| sum + item.quantity*item.price }
  end
end