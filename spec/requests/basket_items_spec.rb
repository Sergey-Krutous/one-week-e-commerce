require 'rails_helper'

RSpec.describe "BasketItems requests", type: :request do
  let(:bag) { FactoryGirl.create :womens_bag }
  
  let(:valid_attributes) {
    {product_id: bag.id}
  }
  
  let(:out_of_stock_attributes) {
    bag.quantity = 0
    bag.save
    {product_id: bag.id}
  }

  describe "POST /basket/items" do
    context "with valid parameters" do
      before(:each) { xhr :post, "/basket/items", valid_attributes }
      
      it "does not have js alerts in the response" do
        expect(response.body).to_not include("alert")
      end
    end
    
    context "with unsufficient stock" do
      before(:each) { xhr :post, "/basket/items", out_of_stock_attributes }
      
      it "sends error message in the response" do
        expect(response.body).to include(Basket::UNSUFFICIENT_STOCK_ERROR_MESSAGE)
      end
      
      it "has js alert in the response" do
        expect(response.body).to include("alert(")
      end
    end
  end
end
