require 'rails_helper'

RSpec.describe BasketItemsController, type: :controller do
  let(:bag) { FactoryGirl.create :womens_bag }
  let(:duvet) { FactoryGirl.create :duvet }

  let(:valid_attributes) {
    {product_id: bag.id}
  }

  let(:out_of_stock_attributes) {
    bag.quantity = 0
    bag.save
    {product_id: bag.id}
  }

  let(:valid_session) { {} }

  describe "POST #create" do
    context "with valid params" do
      before(:each) { xhr :post, :create, valid_attributes }
      
      it "increases item count" do
        expect(subject.instance_variable_get(:@basket).item_count).to eq(1)
      end

      it "renders 'show' template" do
        expect(response).to render_template(:show)
      end
    end

    context "with unsufficient stock" do
      before(:each) { xhr :post, :create, out_of_stock_attributes }
      
      it "does not increase item count" do
        expect(subject.instance_variable_get(:@basket).item_count).to eq(0)
      end

      it "renders 'show' template" do
        expect(response).to render_template(:show)
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      session[:basket] = Basket.new.add_item(bag.id, 3, bag.price).add_item(duvet.id, 5, duvet.price).serialize
      xhr :delete, :destroy, valid_attributes
    end
    
    it "decreases item count" do
      expect(subject.instance_variable_get(:@basket).item_count).to eq(5)
    end
    
    it "decreases basket total" do
      expect(subject.instance_variable_get(:@basket).total).to eq(5*duvet.price)
    end

    it "renders 'show' template" do
      expect(response).to render_template(:show)
    end
  end

end
