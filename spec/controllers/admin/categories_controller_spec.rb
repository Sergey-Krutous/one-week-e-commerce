require 'rails_helper'

RSpec.shared_examples "when parent_id is invalid" do |action|
  context "when parent_id is invalid" do
    subject { get action, {parent_id: Category.maximum(:parent_id).to_i+1}, valid_session }
    it { is_expected.to have_http_status(404) }
  end
end

RSpec.describe Admin::CategoriesController, type: :controller do
  let(:valid_session){ {} }

  let(:valid_attributes) {
    FactoryGirl.attributes_for(:womens_category)
  }

  let(:invalid_attributes) {
    {title: ""}
  }

  describe "GET #index" do
    let(:womens_category){FactoryGirl.create(:womens_category, :with_womens_category_children)}
    let(:mens_category){FactoryGirl.create(:mens_category)}

    it "assigns root categories as @categories" do
      get :index, {}, valid_session
      expect(assigns(:categories)).to eq([womens_category, mens_category])
    end
    
    include_examples "when parent_id is invalid", :index
    
    context "when valid parent id provided" do
      it "assigns child categories as @categories" do
        get :index, {parent_id: womens_category.id}, valid_session
        expect(assigns(:categories)).to eq(womens_category.children.to_a)
      end
    end
  end

  describe "GET #show" do
    it "assigns the requested category as @category" do
      category = Category.create! valid_attributes
      get :show, {:id => category.to_param}, valid_session
      expect(assigns(:category)).to eq(category)
    end
  end

  describe "GET #new" do
    it "assigns a new category as @category" do
      get :new, {}, valid_session
      expect(assigns(:category)).to be_a_new(Category)
    end
    
    include_examples "when parent_id is invalid", :new
  end

  describe "GET #edit" do
    it "assigns the requested category as @category" do
      category = Category.create! valid_attributes
      get :edit, {:id => category.to_param}, valid_session
      expect(assigns(:category)).to eq(category)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Category" do
        expect {
          post :create, {:category => valid_attributes}, valid_session
        }.to change(Category, :count).by(1)
      end

      it "assigns a newly created category as @category" do
        post :create, {:category => valid_attributes}, valid_session
        expect(assigns(:category)).to be_a(Category)
        expect(assigns(:category)).to be_persisted
      end

      it "redirects to the created category" do
        post :create, {:category => valid_attributes}, valid_session
        expect(response).to redirect_to(admin_category_url(Category.last))
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved category as @category" do
        post :create, {:category => invalid_attributes}, valid_session
        expect(assigns(:category)).to be_a_new(Category)
      end

      it "re-renders the 'new' template" do
        post :create, {:category => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_category_state)  {
        category = FactoryGirl.build(:womens_category)
        category.title += "1"
        category.slug += "1"
        category
      }
      let(:new_attributes) {
        new_category_state.attributes
      }
      
      def build_expected_object object, expected_object
        expected_object.id = object.id
        expected_object.created_at = object.created_at
        expected_object.updated_at = object.updated_at
        expected_object
      end

      it "updates the requested category" do
        category = Category.create! valid_attributes
        put :update, {:id => category.to_param, :category => new_attributes}, valid_session
        category.reload
        expect(category).to eq(build_expected_object(category, new_category_state))
      end

      it "assigns the requested category as @category" do
        category = Category.create! valid_attributes
        put :update, {:id => category.to_param, :category => valid_attributes}, valid_session
        expect(assigns(:category)).to eq(category)
      end

      it "redirects to the category" do
        category = Category.create! valid_attributes
        put :update, {:id => category.to_param, :category => valid_attributes}, valid_session
        expect(response).to redirect_to(admin_category_url(category))
      end
    end

    context "with invalid params" do
      it "assigns the category as @category" do
        category = Category.create! valid_attributes
        put :update, {:id => category.to_param, :category => invalid_attributes}, valid_session
        expect(assigns(:category)).to eq(category)
      end

      it "re-renders the 'edit' template" do
        category = Category.create! valid_attributes
        put :update, {:id => category.to_param, :category => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested category" do
      category = Category.create! valid_attributes
      expect {
        delete :destroy, {:id => category.to_param}, valid_session
      }.to change(Category, :count).by(-1)
    end

    it "redirects to the admin_categories list" do
      category = Category.create! valid_attributes
      delete :destroy, {:id => category.to_param}, valid_session
      expect(response).to redirect_to(admin_categories_url)
    end
  end

end
