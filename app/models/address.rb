class Address < ActiveRecord::Base
  validates :email, :first_name, :last_name, :country, :city, :street_address, presence: true
end
