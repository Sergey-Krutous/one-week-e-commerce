require 'rails_helper'

RSpec.describe Product, type: :model do
  include_examples "sluggable model", :duvet
  
  [-1, 0, "a"].each do |price|
    it "should be invalid with the following price: #{price}" do
      FactoryGirl.build(:duvet, price: price).should_not be_valid
    end
  end
end
