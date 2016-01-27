FactoryGirl.define do
  factory :womens_bag_image, class: Image do
    association :product, factory: :womens_bag
    file { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'files', 'anyfile.png')) }
  end
  
  factory :duvet_image, class: Image do
    association :product, factory: :duvet
    file { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'files', 'anyfile.png')) }
  end
end
