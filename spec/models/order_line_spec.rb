require 'rails_helper'

RSpec.describe OrderLine, type: :model do
  let(:valid_order_line) { FactoryGirl.build :order_line_with_order }
  it "has valid factory" do
    expect(valid_order_line).to be_valid
  end
  [:order, :product, :quantity, :price].each do |attribute|
    it "is invalid with empty #{attribute}" do
      order_line = valid_order_line
      order_line.public_send("#{attribute}=", nil)
      expect(order_line).not_to be_valid
    end
  end
  [:quantity, :price].each do |attribute|
    it "is invalid with zero #{attribute}" do
      order_line = valid_order_line
      order_line.public_send("#{attribute}=", 0)
      expect(order_line).not_to be_valid
    end
    it "is invalid with negative #{attribute}" do
      order_line = valid_order_line
      order_line.public_send("#{attribute}=", -1)
      expect(order_line).not_to be_valid
    end
  end
end
