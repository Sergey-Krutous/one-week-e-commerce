require 'rails_helper'

RSpec.describe Admin::ProductsController, type: :controller do
  let(:womens_category) { FactoryGirl.create :womens_category }
  let(:mens_category) { FactoryGirl.create :mens_category }
  let(:duvet) do
    product = FactoryGirl.create :duvet
    product.categories << mens_category
    product
  end

  let(:valid_attributes) {
    FactoryGirl.attributes_for(:womens_bag).merge({ category_ids: [womens_category.id] })
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

      context "and" do
        before(:each) { post :create, {:product => valid_attributes}, valid_session }
        it "assigns a newly created product as @product" do
          expect(assigns(:product)).to be_a(Product)
          expect(assigns(:product)).to be_persisted
        end
  
        it "redirects to the created product" do
          expect(response).to redirect_to(admin_product_url(Product.last))
        end
        
        it "assigns product to category" do
          expect(Product.last.categories).to include(womens_category)
        end
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
        attributes[:category_ids] = [womens_category.id]
        attributes
      }

      before(:each) do
        put :update, {:id => duvet.to_param, :product => new_attributes}, valid_session
        duvet.reload
      end
      
      it "updates the requested product" do
        expect(duvet.price).to eq(new_attributes[:price])
        expect(duvet.quantity).to eq(new_attributes[:quantity])
        expect(duvet.title).to eq(new_attributes[:title])
      end

      it "assigns the requested product as @product" do
        expect(assigns(:product)).to eq(duvet)
      end

      it "redirects to the product" do
        expect(response).to redirect_to(admin_product_url(duvet))
      end
      
      it "assigns product to category" do
        expect(duvet.categories).to include(womens_category)
      end
      
      it "removes category from product" do
        expect(duvet.categories).not_to include(mens_category)
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
