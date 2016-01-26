require 'rails_helper'

RSpec.describe Product, type: :model do
  include_examples "sluggable model", :duvet
  
  [-1, 0, "a"].each do |price|
    it "should be invalid with the following price: #{price}" do
      FactoryGirl.build(:duvet, price: price).should_not be_valid
    end
  end
  
  context "when adding category to product" do
    let(:category) { FactoryGirl.create(:womens_bags_category) }
    let(:product) { FactoryGirl.create(:womens_bag) }
      
    before(:each) do
      product.categories << category
    end
    
    it "category's product list has the product" do
      expect(Category.find_by_id(category.id).products.find_by_id(product.id)).to be_a Product
    end

    it "products's category list has the category" do
      expect(Product.find_by_id(product.id).categories.find_by_id(category.id)).to be_a Category
    end
  end
end
