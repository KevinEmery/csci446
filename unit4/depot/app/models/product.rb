class Product < ActiveRecord::Base
  
  default_scope :order => 'title'
  has_many :line_items
  
  before_destroy :ensure_not_referenced_by_any_line_item
  
  # ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    
    if line_items.count.zero?
      return true
    else
      errors.add(:base, 'Line Items present' )
      return false
    end
  end
  
  # Validates the existence of the title, description, and url
  validates :title, :description, :image_url, :presence => true
  
  # Validates that the given price is >= 0.01
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  
  # Validates that the title is unique
  validates :title, :uniqueness => true
  
  validates :image_url, allow_blank: true, :format => { :with => %r{\.(gif|jpg|png)\Z}i, :message => 'must be a URL for GIF, JPG or PNG image.'}
end
