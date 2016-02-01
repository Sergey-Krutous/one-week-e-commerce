describe "Checkout feature", type: :feature do
  include_examples "shared feature specs"
  let(:product) { FactoryGirl.create :duvet, quantity: 2 }
  let(:address_attributes) { FactoryGirl.attributes_for :address }
  context "when adding product to basket and clicking Checkout link" do
    before(:each) do
      #open PDP by product id and add product to basket
      visit product_path(product)
      click_button 'Add to cart'
      
      #open PDP by product slug and add product to basket
      visit product.slug
      click_button 'Add to cart'
      
      within("#basket") do
        #go to Checkout page
        click_link("Checkout")
      end
    end
    
    it "opens checkout page" do
      expect(page).to have_title "Checkout"
    end
    
    context "and filling checkout form" do
      before(:each) do
        within("form") do
          address_attributes.each do |key, value|
            fill_in "order[billing_address][#{key}]", :with => value
          end
        end
        previous_order_id = Order.last ? Order.last.id : 0
        click_button 'Confirm Order'
        @last_order_id = Order.last.id
        expect(@last_order_id).to be > previous_order_id
      end
      
      it "opens order confirmation page" do
        expect(page).to have_title "Order Confirmation"
      end
      
      it "displays 2 ordered items" do
        expect(page.find("table").find("tbody").all("td")[1]).to have_content("2")
      end
      it "displays ordered item price" do
        expect(page.find("table").find("tbody").all("td")[2]).to have_content(product.price.to_s)
      end
      it "displays ordered item total" do
        expect(page.find("table").find("tbody").all("td")[3]).to have_content((2*product.price).to_s)
      end
      
      context "and admin" do
        before(:each) do
          login
        end
        it "can see the order in the order list" do
          visit admin_orders_path
          expect(page.find("table").find_link(@last_order_id.to_s)[:href]).to eq(admin_order_path(@last_order_id))
        end
        it "can see the order details" do
          visit admin_order_path(@last_order_id)
          expect(page).to have_title "Order ##{@last_order_id}"
        end
      end
    end
  end
end