FactoryGirl.define do
  factory :address do
    email "museum@example.com"
    first_name "Museum"
    last_name "Natural History"
    country "US"
    state "NY"
    city "New York"
    street_address "Central Park West at 79th Street"
    zip "10024"
  end

  factory :another_address, class: Address do
    email "bank@example.com"
    first_name "Bank of New York"
    last_name "Federal Reserve"
    country "US"
    state "NY"
    city "New York"
    street_address "33 Maiden Ln #14"
    zip "10038"
  end
end
