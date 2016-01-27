require 'rails_helper'

RSpec.describe Image, type: :model do
  let(:valid_image){ FactoryGirl.build :duvet_image }
  let(:image_without_product){ FactoryGirl.build :duvet_image, product: nil }
  let(:image_without_file){ FactoryGirl.build :duvet_image, file: nil }
  it "has valid factory" do
    expect(valid_image).to be_valid
  end
  it "is invalid without product" do
    expect(image_without_product).not_to be_valid
  end
  it "is invalid without file" do
    expect(image_without_file).not_to be_valid
  end
end
