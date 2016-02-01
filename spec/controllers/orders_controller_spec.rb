require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:bag) { FactoryGirl.create :womens_bag }

  let(:valid_order_params) {
    FactoryGirl.attributes_for(:order).merge(
      {:billing_address => FactoryGirl.attributes_for(:address),
      :shipping_address => FactoryGirl.attributes_for(:another_address),
      :order_lines => { "0" => FactoryGirl.attributes_for(:order_line, :product_id => bag.id)}
      })
  }

  def bag!
    Product.find bag.id
  end
  
  let(:zero_lines_order_params) {
    valid_order_params.delete :order_lines
    valid_order_params
  }
  
  let(:out_of_stock_order_params) {
    valid_order_params[:order_lines]["0"][:quantity] = bag.quantity + 1
    valid_order_params
  }
  
  let(:invalid_attributes) {
    invalid_params = valid_order_params
    invalid_params[:billing_address][:email] = nil
    invalid_params
  }

  let(:valid_session) { 
    subject.instance_eval{ basket }.add_item bag.id, 1, bag.price
    subject.instance_eval{ session }
  }

  describe "GET #show" do
    before(:each) { post :create, {:order => valid_order_params}, valid_session }
    let(:order) { Order.last }
    it "assigns the requested order as @order" do
      cookies[:orders] = order.id.to_s
      get :show, {:id => order.to_param}, valid_session
      expect(assigns(:order)).to eq(order)
    end
    
    context "when cookies does not have order id" do
      it "renders 404 not found" do
        cookies.delete :orders
        get :show, {:id => order.to_param}, valid_session
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "GET #new" do
    it "assigns a new order as @order" do
      get :new, {}, valid_session
      expect(assigns(:order)).to be_a_new(Order)
    end
    context "with zero lines" do
      it "redirects to home" do
        get :new
        expect(response).to redirect_to(root_url)
      end
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Order" do
        expect {
          post :create, {:order => valid_order_params}, valid_session
        }.to change(Order, :count).by(1)
      end
      it "decreases stock" do
        expect {
          post :create, {:order => valid_order_params}, valid_session
        }.to change{ bag!.quantity }.by(-FactoryGirl.attributes_for(:order_line)[:quantity])
      end
      context "and" do
        before(:each) { post :create, {:order => valid_order_params}, valid_session } 
        it "assigns a newly created order as @order" do
          expect(assigns(:order)).to be_a(Order)
        end
        it "persists the order" do
          expect(assigns(:order)).to be_persisted
        end
        it "redirects to the created order" do
          expect(response).to redirect_to(Order.last)
        end
        it "clears basket" do
          expect(subject.instance_eval{ basket }.item_count).to be_zero
        end
        it "saves order number in cookies" do
          expect(cookies[:orders]).to include(Order.last.id)
        end
      end
    end
    
    context "with zero lines" do
      it "does not create an Order" do
        expect {
          post :create, {:order => zero_lines_order_params}, valid_session
        }.to change(Order, :count).by(0)
      end

      it "redirects to home" do
        post :create, {:order => zero_lines_order_params}, valid_session
        expect(response).to redirect_to(root_url)
      end
    end
    
    context "with unsufficient stock" do
      it "does not create an Order" do
        expect {
          post :create, {:order => out_of_stock_order_params}, valid_session
        }.to change(Order, :count).by(0)
      end

      it "re-renders order submission form" do
        post :create, {:order => out_of_stock_order_params}, valid_session
        expect(response).to render_template(:new)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved order as @order" do
        post :create, {:order => invalid_attributes}, valid_session
        expect(assigns(:order)).to be_a_new(Order)
      end

      it "re-renders the 'new' template" do
        post :create, {:order => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end
end
