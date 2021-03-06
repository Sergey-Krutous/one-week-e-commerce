require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:womens_category){ FactoryGirl.create(:womens_category, :with_womens_category_children)}
  let(:womens_bags_category){ womens_category.children[0] }
  it "belongs to parent which is category" do
    expect(womens_bags_category.parent).to be_a Category
  end

  include_examples "sluggable model", :womens_category
  
  it "should be invalid with too short title" do
    FactoryGirl.build(:womens_category, title: "a").should_not be_valid
  end
  
  it "should be invalid with duplicate title" do
    first_category = FactoryGirl.create(:womens_category)
    FactoryGirl.build(:mens_category, title: first_category.title).should_not be_valid
  end
  
  context "when adding product to category" do
    let(:category) { FactoryGirl.create(:womens_bags_category) }
    let(:product) { FactoryGirl.create(:womens_bag) }
      
    before(:each) do
      category.products << product
    end
    
    it "category's product list has the product" do
      expect(Category.find_by_id(category.id).products.find_by_id(product.id)).to be_a Product
    end

    it "products's category list has the category" do
      expect(Product.find_by_id(product.id).categories.find_by_id(category.id)).to be_a Category
    end
  end

end
