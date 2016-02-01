RSpec.shared_examples "shared feature specs" do
  def clear_cookies
    browser = Capybara.current_session.driver.browser
    if browser.respond_to?(:clear_cookies)
      # Rack::MockSession
      browser.clear_cookies
    elsif browser.respond_to?(:manage) and browser.manage.respond_to?(:delete_all_cookies)
      # Selenium::WebDriver
      browser.manage.delete_all_cookies
    else
      raise "Don't know how to clear cookies. Weird driver?"
    end
  end
  
  def login
    visit log_in_path
    within("form") do
      fill_in 'login', :with => SessionsController::ADMIN_LOGIN
      fill_in 'password', :with => SessionsController::ADMIN_PASS
    end
    click_button 'login'
  end
end