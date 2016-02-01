require 'rails_helper'

RSpec.describe Address, type: :model do
  it "should have valid factory" do
    FactoryGirl.build(:address).should be_valid
  end

  [:email, :first_name, :last_name, :country, :city, :street_address].each do |attribute|  
    it "should be invalid with empty #{attribute}" do
        FactoryGirl.build(:address, attribute => nil).should_not be_valid
    end
  end
end
