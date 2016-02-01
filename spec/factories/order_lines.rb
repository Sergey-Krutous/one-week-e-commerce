FactoryGirl.define do
  factory :order_line do
    association :product, factory: :duvet
    price "9.99"
    quantity 3
    factory :order_line_with_order do
      association :order, factory: [:order, :with_single_address]
    end
  end
end
