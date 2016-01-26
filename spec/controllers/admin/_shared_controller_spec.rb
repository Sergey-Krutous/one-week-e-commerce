RSpec.shared_examples "admin controller session" do
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Admin::CategoriesController. Be sure to keep this updated too.
  let(:valid_session) { session[:user_id] = SessionsController::ADMIN_LOGIN; session }
end

RSpec.shared_examples "requires authorization" do |actions|
  context 'when logged in' do
    before(:each) do
      session[:user_id] = SessionsController::ADMIN_LOGIN
    end
    actions.each do |action|
      context "and requesting /#{action}" do
        subject { get action, request_parameters }
        it { is_expected.to have_http_status(:ok) }
      end
    end
  end
  context 'when not logged in' do
    before(:each) do
      session.delete :user_id
    end
    actions.each do |action|
      context "and requesting /#{action}" do
        subject { get action, request_parameters }
        it { is_expected.to redirect_to(log_in_url) }
      end
    end
  end
end