feature "Sessions" do
  include_examples "shared feature specs"
  scenario "Signing in with correct credentials" do
    login
    expect(page).to have_content 'Logout'
  end
end