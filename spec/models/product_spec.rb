require 'rails_helper'

RSpec.describe Product, type: :model do
  include_examples "sluggable model", :duvet
end
