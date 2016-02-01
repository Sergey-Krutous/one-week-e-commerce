require 'rails_helper'

RSpec.describe Admin::OrdersController, type: :controller do
  include_examples "admin controller session"

  let(:order) { FactoryGirl.create :order, :with_two_addresses, :with_single_order_line }

  before(:each) { order }

  describe "GET #index" do
    it "assigns all orders as @orders" do
      get :index, {}, valid_session
      expect(assigns(:orders)).to eq([order])
    end
  end

  describe "GET #show" do
    it "assigns the requested order as @order" do
      get :show, {:id => order.to_param}, valid_session
      expect(assigns(:order)).to eq(order)
    end
  end
end
