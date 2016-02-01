FactoryGirl.define do
  factory :order_line do
    association :order, factory: [:order, :with_single_address]
    association :product, factory: :duvet
    price "9.99"
    quantity 3
  end
end
