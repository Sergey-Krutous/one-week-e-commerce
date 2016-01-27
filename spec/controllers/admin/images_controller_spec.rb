require 'rails_helper'

RSpec.shared_examples "when product_id is invalid" do |action|
  context "when product_id is invalid" do
    subject { get action, {product_id: Product.maximum(:id).to_i+1}, valid_session }
    it { is_expected.to have_http_status(404) }
  end
end

RSpec.describe Admin::ImagesController, type: :controller do
  include_examples "admin controller session"

  let(:product) { FactoryGirl.create(:womens_bag) }

  let(:valid_attributes) {
    FactoryGirl.attributes_for(:womens_bag_image)
  }

  let(:invalid_attributes) {
    {}
  }

  it_behaves_like "requires authorization", [:index] do
    let(:request_parameters) {{product_id: FactoryGirl.create(:womens_bag).id}}
  end

  describe "GET #index" do
    it "assigns product images as @images" do
      womens_bag_image = FactoryGirl.create(:womens_bag_image)
      duvet_image = FactoryGirl.create(:duvet_image)
      get :index, { product_id: womens_bag_image.product.id}, valid_session
      expect(assigns(:images)).to eq([womens_bag_image])
    end
    
    include_examples "when product_id is invalid", :index
  end

  describe "GET #new" do
    it "assigns a new image as @image" do
      get :new, { product_id: product.id }, valid_session
      expect(assigns(:image)).to be_a_new(Image)
    end
    
    include_examples "when product_id is invalid", :new
  end

  describe "POST #create" do
    
    context "with valid params" do
      it "creates a new Image" do
        expect {
          post :create, {product_id: product.id, image: valid_attributes}, valid_session
        }.to change(Image, :count).by(1)
      end

      it "assigns a newly created image as @image" do
        post :create, {product_id: product.id, image: valid_attributes}, valid_session
        expect(assigns(:image)).to be_a(Image)
        expect(assigns(:image)).to be_persisted
      end

      it "redirects to the list of product images" do
        post :create, {product_id: product.id, image: valid_attributes}, valid_session
        expect(response).to redirect_to(admin_images_url({product_id: product.id}))
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved image as @image" do
        post :create, {product_id: product.id, :image => invalid_attributes}, valid_session
        expect(assigns(:image)).to be_a_new(Image)
      end

      it "re-renders the 'new' template" do
        post :create, {product_id: product.id, :image => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested image" do
      image = FactoryGirl.create(:womens_bag_image)
      expect {
        delete :destroy, {:id => image.to_param}, valid_session
      }.to change(Image, :count).by(-1)
    end

    it "redirects to the images list" do
      image = FactoryGirl.create(:womens_bag_image)
      product = image.product
      delete :destroy, {:id => image.to_param}, valid_session
      expect(response).to redirect_to(admin_images_url({product_id: product.id}))
    end
  end

end
