RSpec.shared_examples "sluggable model" do |factory|
  it "should have valid factory" do
    FactoryGirl.build(factory).should be_valid
  end
  
  [nil, ""].each do |title|
    it "should be invalid with title: #{title.inspect}" do
      FactoryGirl.build(factory, title: title).should_not be_valid
    end
  end
  
  it "should be valid with empty slug" do
    FactoryGirl.build(factory, slug: "").should be_valid
  end
    
  it "should have invalid slug without leading slash" do
    FactoryGirl.build(factory, slug: "this-is-slug").should_not be_valid
  end
end