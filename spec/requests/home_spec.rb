require 'rails_helper'

RSpec.describe "Home", type: :request do
  describe "GET /" do
    it "application root URL responds with OK" do
      get root_path
      expect(response).to have_http_status(200)
    end
  end
end
