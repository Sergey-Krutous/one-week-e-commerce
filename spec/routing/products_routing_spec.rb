require "rails_helper"

RSpec.describe ProductsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/products").to route_to("products#index")
    end

    it "routes to #show" do
      expect(:get => "/products/1").to route_to("products#show", :id => "1")
    end

    ["bag", "fancy-bag", "bags/bag", "fancy-bags/fancy-bag", "products/bag"].each do |slug|
      it "routes to #index by slug" do
        expect(:get => "/#{slug}").to route_to("products#index", slug: slug)
      end
    end
  end
end
