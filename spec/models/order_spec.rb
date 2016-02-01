require 'rails_helper'

RSpec.describe Order, type: :model do
  context "when saving order with the same shipping and billing address" do
    let(:order) { FactoryGirl.create :order, :with_single_address }
    it "has billing address saved" do
      expect(Order.find(order.id).billing_address).to be_a Address
    end
    it "has billing address with correct email" do
      expect(Order.find(order.id).billing_address.email).to eq(FactoryGirl.attributes_for(:address)[:email])
    end
    it "has shipping address saved" do
      expect(Order.find(order.id).shipping_address).to be_a Address
    end
    it "has shipping address with correct email" do
      expect(Order.find(order.id).shipping_address.email).to eq(FactoryGirl.attributes_for(:address)[:email])
    end
  end
  
  context "when saving order with the different shipping and billing address" do
    let(:order) { FactoryGirl.create :order, :with_two_addresses }
    it "has billing address saved" do
      expect(Order.find(order.id).billing_address).to be_a Address
    end
    it "has billing address with correct email" do
      expect(Order.find(order.id).billing_address.email).to eq(FactoryGirl.attributes_for(:address)[:email])
    end
    it "has shipping address saved" do
      expect(Order.find(order.id).shipping_address).to be_a Address
    end
    it "has shipping address with correct email" do
      expect(Order.find(order.id).shipping_address.email).to eq(FactoryGirl.attributes_for(:another_address)[:email])
    end
  end
end
