FactoryGirl.define do
  factory :duvet, class: Product do
    title "Slumberdown Winter Warm Duvet"
    slug  "/products/slumberdown-winter-warm-duvet"
    description "The Slumberdown Winter Warm duvet is perfect for keeping you warm and cosy on cold winter nights. It's high tog rating means you can be sure it has enough filling to keep you extra warm all night long. Our lovely and snuggly hollowfibre filling is soft and comfortable. Our easycare soft polyester cotton is great at recovering its shape after washing and drying. Machine washable at 40."
    price 14
    quantity 1111
  end
  
  factory :womens_bag, class: Product do
    title "Strap Tag Tote Bag"
    description "Tan strap tag tote handbag featuring eyelet and buckle detail."
    price 22
    quantity 5555
  end
end
