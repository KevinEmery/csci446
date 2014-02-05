class Product < ActiveRecord::Base
  
  # Validates the existence of the title, description, and url
  validates :title, :description, :image_url, :presence => true
  
  # Validates that the given price is >= 0.01
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  
  # Validates that the title is unique
  validates :title, :uniqueness => true
  
  validates :image_url, allow_blank: true, :format => { :with => %r{\.(gif|jpg|png)\Z}i, :message => 'must be a URL for GIF, JPG or PNG image.'}
end
