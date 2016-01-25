FactoryGirl.define do
  factory :womens_category, class: Category do
    title "Womens department"
  end
  
  trait :with_womens_category_children do
    after(:create) do |node|
      create(:womens_bags_category).move_to_child_of(node)
      create(:womens_dresses_category).move_to_child_of(node)
      node.reload
    end
  end
  
  factory :womens_bags_category, class: Category do
    title "Womens Bags"
  end
  
  factory :womens_dresses_category, class: Category do
    title "Dresses"
  end
end
