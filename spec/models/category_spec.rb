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

end
