require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
    let(:valid_attributes) {
    { login: SessionsController::ADMIN_LOGIN, password: SessionsController::ADMIN_PASS }
  }
  
  let(:invalid_attributes) {
    { login: SessionsController::ADMIN_LOGIN, password: "qwerty"}
  }
  
  describe "POST #create" do
    context "with valid params" do
      before(:each) { post :create, valid_attributes }
      it "redirects to admin dashboard" do
        expect(response).to redirect_to(admin_dashboard_url)
      end
      
      it "saves login in session" do
        expect(session[:user_id]).to eq(SessionsController::ADMIN_LOGIN)
      end
    end

    context "with invalid params" do
      before(:each) { post :create, invalid_attributes; session.delete :user_id }
      it "does not save login in session" do
        expect(session[:user_id]).to be_nil
      end

      it "re-renders the 'new' template" do
        expect(response).to render_template("new")
      end
    end
  end
  
  describe "DELETE #destroy" do
    before(:each) do
      session[:user_id] = SessionsController::ADMIN_LOGIN
      delete :destroy
    end

    it "redirects to home page" do
      expect(response).to redirect_to(root_url)
    end
          
    it "removes login from session" do
      expect(session[:user_id]).to be_nil
    end
  end
end