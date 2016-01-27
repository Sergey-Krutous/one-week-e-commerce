require 'pathname'

class Image < ActiveRecord::Base
  belongs_to :product
  
  mount_uploader :file, ImageUploader
  
  validates :product, presence: true
  validates :file, presence: true
end
