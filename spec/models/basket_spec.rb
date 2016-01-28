require 'rails_helper'

RSpec.describe Basket, type: :model do
  subject { Basket.new }
  let(:bag) { FactoryGirl.create :womens_bag }
  let(:duvet) { FactoryGirl.create :duvet }

  #single product tests
  [[],[{:price => 0,:quantity => 0}],[{:price => 0,:quantity => 1}],[{:price => 0.55,:quantity => 10}],
  [{:price => 0.55,:quantity => 10}, {:price => 0.99,:quantity => 20}]].each do |args|
    sum = BigDecimal.new("0")
    count = 0
    serialized = Hash.new
    serialized[:items] = args
    items = []
    args.each do |arg|
      count += arg[:quantity]
      items << BasketItem.new(arg)
    end
    sum = BigDecimal.new(args.last[:price],Math.log10(args.last[:price]+0.01).ceil + 2)*count if count > 0

    context "when the following single product items added: #{args}" do
      before(:each) { args.each { |arg| subject.add_item bag.id, arg[:quantity], arg[:price] } }
      it "increases item count by #{count}" do
        expect(subject.item_count).to eq count
      end
      it "increases total by #{sum}" do
        expect(subject.total).to eq sum
      end
      it "does not have an error message" do
        expect(subject.error_message).to be_blank
      end
    end
    
    context "when the basket is deserialized from Hash with the following items: #{args}" do
      subject { Basket.new serialized}
      before(:each) { serialized[:items].each { |item| item[:product_id] = bag.id } }
      it "has right total" do
        expect(subject.total).to eq sum
      end
    end
  end
  
  #two products tests
  context "when the different product items" do
    before(:each) { subject.add_item(bag.id,1,5).add_item(duvet.id,10,50.01) }
    it "correctly increases total" do
      expect(subject.total).to eq 505.1
    end
    it "does not have an error message" do
      expect(subject.error_message).to be_blank
    end
  end
  
  context "when the basket is deserialized from Hash" do
    subject { Basket.new({items: [{product_id: bag.id, quantity: 1, price: 5}, {product_id: duvet.id, quantity: 10, price: 50.01}]}) }
    it "has right total" do
      expect(subject.total).to eq 505.1
    end
    it "does not have an error message" do
      expect(subject.error_message).to be_blank
    end
  end

  context "when adding non-existing product_id" do
    subject { Basket.new }
    before(:each) { FactoryGirl.create :womens_bag }
    it "does not add an item" do
      expect { subject.add_item Product.maximum(:id)+1, 1, 10.0 }.to change(subject, :item_count).by(0)
    end
    it "does not have error message" do
      expect(subject.add_item(Product.maximum(:id)+1, 1, 10.0).error_message).to be_blank
    end
  end
  
  [[0, 1],[1,2],[1,100]].each do |args|
    context "when adding unsufficient stock: #{args[1]} vs #{args[0]} on hand" do
      let(:bag) { FactoryGirl.create(:womens_bag, quantity: args[0]) }
      it "does not add an item" do
        expect { subject.add_item bag.id, args[1], 10.0 }.to change(subject, :item_count).by(0)
      end
      it "has error message" do
        expect(subject.add_item(bag.id, args[1], 10.0).error_message).not_to be_blank
      end
    end
  end
  
  context "when deleting items" do
    subject { Basket.new.add_item(bag.id, 10, 1.0).add_item(duvet.id, 100, 4.0) }
    it "can delete first product_id" do
      expect { subject.delete_item bag.id }.to change(subject, :item_count).by(-10)
    end
    it "can delete last product_id" do
      expect { subject.delete_item duvet.id }.to change(subject, :item_count).by(-100)
    end
    it "does not delete non-existing product_id" do
      expect { subject.delete_item 4 }.to change(subject, :item_count).by(0)
    end
  end
end