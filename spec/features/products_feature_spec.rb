describe "Product feature", type: :feature do
  let(:category_attributes) { FactoryGirl.attributes_for(:womens_category) }
  let(:product_attributes) { FactoryGirl.attributes_for(:duvet) }
  let(:product) { Product.find_by_title product_attributes[:title] }
  let(:category) { Category.find_by_title(category_attributes[:title]) }
  
  include_examples "shared feature specs"
  
  before(:each) do
    login
    
    #create category
    visit new_admin_category_path
    within("form") do
      fill_in 'category[title]', :with => category_attributes[:title]
      fill_in 'category[slug]', :with => category_attributes[:slug]
    end
    click_button 'Save'

    #create product
    visit new_admin_product_path
    within("form") do
      fill_in 'product[title]', :with => product_attributes[:title]
      fill_in 'product[slug]', :with => product_attributes[:slug]
      fill_in 'product[description]', :with => product_attributes[:description]
      fill_in 'product[price]', :with => product_attributes[:price]
      fill_in 'product[quantity]', :with => product_attributes[:quantity]
      find("select").find(:option, text: category.title).select_option
    end
    click_button 'Save'
    
    clear_cookies
  end
  
  context "when opening PDP by product id" do
    it "sets page title to product title" do
      visit product_path(product)
      expect(page).to have_title(product.title)
    end
  end

  context "when opening PDP by product slug" do
    it "sets page title to product title" do
      visit product.slug
      expect(page).to have_title product.title
    end
  end
  
  context "when opening PDP by category slug" do
    before(:each) { visit category.slug }
    it "sets page title to category title" do
      expect(page).to have_title category.title
    end
    it "contains product title" do
      expect(page).to have_content product.title
    end
  end
  
  context "when product is out of stock" do
    before(:each) do
      login
      visit edit_admin_product_path(product)
      within("form") do
        fill_in 'product[quantity]', :with => "0"
      end
      click_button 'Save'
    end
    
    context "and opening PDP by product id" do
      it "returns status 404 not found" do
        visit product_path(product)
        expect(page.status_code).to eq(404)
      end
    end
  
    context "and opening PDP by product slug" do
      it "returns status 404 not found" do
        visit product.slug
        expect(page.status_code).to eq(404)
      end
    end
    
    context "and opening PLP by category slug" do
      it "does not contain product title" do
        visit category.slug
        expect(page).not_to have_content product.title
      end
    end
  end
end