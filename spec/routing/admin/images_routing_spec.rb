require "rails_helper"

RSpec.describe Admin::ImagesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/admin/products/2/images").to route_to("admin/images#index", :product_id => "2")
    end

    it "routes to #new" do
      expect(:get => "/admin/products/2/images/new").to route_to("admin/images#new", :product_id => "2")
    end

    it "routes to #create" do
      expect(:post => "/admin/products/2/images").to route_to("admin/images#create", :product_id => "2")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/images/3").to route_to("admin/images#destroy", :id => "3")
    end
  end
end
