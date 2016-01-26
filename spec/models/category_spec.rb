require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:womens_category){ FactoryGirl.create(:womens_category, :with_womens_category_children)}
  let(:womens_bags_category){ womens_category.children[0] }
  it "belongs to parent which is category" do
    expect(womens_bags_category.parent).to be_a Category
  end

  it "should have valid factory" do
    FactoryGirl.build(:womens_category).should be_valid
  end

  [nil, "", "a"].each do |title|
    it "should be invalid with title: #{title.inspect}" do
      FactoryGirl.build(:womens_category, title: title).should_not be_valid
    end
  end
  
  it "should be invalid with duplicate title" do
    first_category = FactoryGirl.create(:womens_category)
    FactoryGirl.build(:mens_category, title: first_category.title).should_not be_valid
  end
end
