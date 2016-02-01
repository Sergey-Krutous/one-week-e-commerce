require "rails_helper"

RSpec.describe AdminController, type: :routing do
  describe "routing" do
    it "routes to #new" do
      expect(:get => "/admin/preview").to route_to("admin#preview")
    end

    it "routes to #dashboard" do
      expect(:get => "/admin/dashboard").to route_to("admin#dashboard")
    end
  end
end