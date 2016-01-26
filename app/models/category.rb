class Category < Sluggable
  acts_as_nested_set  #adding 'parent' property with nested set

  has_and_belongs_to_many :products

  validates :title, presence: true, length: { minimum: 2 }, uniqueness: { case_sensitive: false }
  
  def indent_title number_of_characters=2, indent_character='&nbsp;'
    (indent_character*number_of_characters*depth + title).html_safe
  end
end
