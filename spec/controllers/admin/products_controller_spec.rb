require 'rails_helper'

RSpec.describe Admin::ProductsController, type: :controller do
  let(:duvet) { FactoryGirl.create :duvet }

  let(:valid_attributes) {
    FactoryGirl.attributes_for(:womens_bag)
  }
  
  let(:invalid_attributes) {
    {title: ""}
  }
  
  include_examples "admin controller session"

  it_behaves_like "requires authorization", [:new, :index] do
    let(:request_parameters) {{}}
  end
  it_behaves_like "requires authorization", [:show, :edit] do
     let(:request_parameters) {{id: FactoryGirl.create(:womens_bag).id}}
  end

  describe "GET #index" do
    it "assigns all products as @products" do
      product = duvet
      get :index, {}, valid_session
      expect(assigns(:products)).to eq([product])
    end
  end

  describe "GET #show" do
    it "assigns the requested product as @product" do
      product = duvet
      get :show, {:id => product.to_param}, valid_session
      expect(assigns(:product)).to eq(product)
    end
  end

  describe "GET #new" do
    it "assigns a new product as @product" do
      get :new, {}, valid_session
      expect(assigns(:product)).to be_a_new(Product)
    end
  end

  describe "GET #edit" do
    it "assigns the requested product as @product" do
      product = duvet
      get :edit, {:id => product.to_param}, valid_session
      expect(assigns(:product)).to eq(product)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Product" do
        expect {
          post :create, {:product => valid_attributes}, valid_session
        }.to change(Product, :count).by(1)
      end

      it "assigns a newly created product as @product" do
        post :create, {:product => valid_attributes}, valid_session
        expect(assigns(:product)).to be_a(Product)
        expect(assigns(:product)).to be_persisted
      end

      it "redirects to the created product" do
        post :create, {:product => valid_attributes}, valid_session
        expect(response).to redirect_to(admin_product_url(Product.last))
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved product as @product" do
        post :create, {:product => invalid_attributes}, valid_session
        expect(assigns(:product)).to be_a_new(Product)
      end

      it "re-renders the 'new' template" do
        post :create, {:product => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        attributes = FactoryGirl.attributes_for(:duvet);
        attributes[:price] += 1.23
        attributes[:quantity] += 1
        attributes[:title] += "!"
        attributes
      }

      it "updates the requested product" do
        product = duvet
        put :update, {:id => product.to_param, :product => new_attributes}, valid_session
        product.reload
        expect(product.price).to eq(new_attributes[:price])
        expect(product.quantity).to eq(new_attributes[:quantity])
        expect(product.title).to eq(new_attributes[:title])
      end

      it "assigns the requested product as @product" do
        product = duvet
        put :update, {:id => product.to_param, :product => valid_attributes}, valid_session
        expect(assigns(:product)).to eq(product)
      end

      it "redirects to the product" do
        product = Product.create! valid_attributes
        put :update, {:id => product.to_param, :product => valid_attributes}, valid_session
        expect(response).to redirect_to(admin_product_url(product))
      end
    end

    context "with invalid params" do
      it "assigns the product as @product" do
        product = duvet
        put :update, {:id => product.to_param, :product => invalid_attributes}, valid_session
        expect(assigns(:product)).to eq(product)
      end

      it "re-renders the 'edit' template" do
        product = Product.create! valid_attributes
        put :update, {:id => product.to_param, :product => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested product" do
      product = duvet
      expect {
        delete :destroy, {:id => product.to_param}, valid_session
      }.to change(Product, :count).by(-1)
    end

    it "redirects to the products list" do
      product = duvet
      delete :destroy, {:id => product.to_param}, valid_session
      expect(response).to redirect_to(admin_products_url)
    end
  end

end
