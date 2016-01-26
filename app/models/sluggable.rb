class Sluggable < ActiveRecord::Base
  self.abstract_class = true
  
  validates :slug, format: { with: /\A\/.+/, message: "URL slug should start with slash ('/') and have at least one more character" }, allow_nil: true
  
  before_validation :clear_blank_slug
  
  def clear_blank_slug
    self.slug = nil if slug.blank?
  end
end