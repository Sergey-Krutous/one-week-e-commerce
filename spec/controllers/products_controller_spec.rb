require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  
  context "GET #index with product slug" do
    describe "when slug is valid" do
      let(:product) { FactoryGirl.create :duvet }
      before(:each) { get :index, slug: product.slug }
      it "renders PDP view" do
        expect(response).to render_template("show")
      end
      it "assigns @product to the selected product" do
        expect(assigns(:product)).to eq(product)
      end
    end
    describe "when slug is valid but no stock available" do
      it "responds with 404 not found" do
        product = FactoryGirl.create(:duvet, quantity: 0)
        get :index, slug: product.slug
        expect(response).to have_http_status(404)
      end
    end
    describe "when slug is invalid" do
      it "responds with 404 not found" do
        get :index, slug: Time.new.to_s
        expect(response).to have_http_status(404)
      end
    end
  end

  [[0,0],[0,5],[10,0],[101, 1500]].each do |qty1, qty2|
    context "when product quantities are #{qty1} and #{qty2}" do
      describe "GET #index" do
        it "assigns all products as @products" do
          product1 = FactoryGirl.create(:womens_bag, quantity: qty1)
          product2 = FactoryGirl.create(:duvet, quantity: qty2)
          get :index
          expected = []
          expected << product1 if qty1 > 0
          expected << product2 if qty2 > 0
          expect(assigns(:products)).to eq(expected)
        end
      end

      describe "GET #index with category_id parameter" do
        it "assigns all products as @products" do
          product1 = FactoryGirl.create(:womens_bag, quantity: qty1)
          product2 = FactoryGirl.create(:duvet, quantity: qty2)
          category = FactoryGirl.create(:womens_category)
          category.products << product1
          category.products << product2
          get :index, category_id: category.id
          expected = []
          expected << product1 if qty1 > 0
          expected << product2 if qty2 > 0
          expect(assigns(:products)).to eq(expected)
        end
      end
      
      describe "GET #index with category slug" do
        it "assigns all products as @products" do
          product1 = FactoryGirl.create(:womens_bag, quantity: qty1)
          product2 = FactoryGirl.create(:duvet, quantity: qty2)
          category = FactoryGirl.create(:womens_category)
          category.products << product1
          category.products << product2
          get :index, slug: category.slug
          expected = []
          expected << product1 if qty1 > 0
          expected << product2 if qty2 > 0
          expect(assigns(:products)).to eq(expected)
        end
      end
    end
  end
  
  context "when product quantity is 0" do
    describe "GET #show" do
      it "returns status 404 not found" do
        product = FactoryGirl.create(:womens_bag, quantity: 0)
        get :show, {:id => product.to_param}
        expect(response).to have_http_status(404)
      end
    end
    
    describe "GET #index with product slug" do
      it "returns status 404 not found" do
        product = FactoryGirl.create(:duvet, quantity: 0)
        get :index, {slug: product.slug}
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "GET #show" do
    it "assigns the requested product as @product" do
      product = FactoryGirl.create(:womens_bag)
      get :show, {:id => product.to_param}
      expect(assigns(:product)).to eq(product)
    end
  end
end
