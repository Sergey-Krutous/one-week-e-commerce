require "rails_helper"

RSpec.describe BasketItemsController, type: :routing do
  describe "routing" do
    it "routes to #create" do
      expect(:post => 'basket/items').to route_to('basket_items#create')
    end

    it "routes to #destroy" do
      expect(:delete => 'basket/items/5').to route_to("basket_items#destroy", :product_id => "5")
    end
  end
end
