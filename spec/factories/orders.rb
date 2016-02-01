FactoryGirl.define do
  trait :with_single_address do
    before(:create) do |order|
      address = create(:address)
      order.billing_address = address
      order.shipping_address = address
    end
  end
  
  trait :with_two_addresses do
    before(:create) do |order|
      order.billing_address = create(:address)
      order.shipping_address = create(:another_address)
    end
  end
  
  trait :with_single_order_line do
    after(:create) do |order|
      bag = create(:womens_bag)
      order.order_lines << create(:order_line, product_id: bag.id)
    end
  end
  
  factory :order do
    date "2016-02-01"
  end
end
