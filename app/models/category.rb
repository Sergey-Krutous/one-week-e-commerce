class Category < ActiveRecord::Base
  acts_as_nested_set  #adding 'parent' property with nested set

  validates :title, presence: true, length: { minimum: 2 }
end