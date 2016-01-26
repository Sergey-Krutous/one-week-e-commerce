class Category < Sluggable
  acts_as_nested_set  #adding 'parent' property with nested set

  validates :title, presence: true, length: { minimum: 2 }, uniqueness: { case_sensitive: false }
end
