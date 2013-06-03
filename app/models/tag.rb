class Tag < ActiveRecord::Base
  attr_accessible :name
  has_many :taggings
  has_many :projects, through: :taggings
  
  validates :name, presence: true, uniqueness: true
  before_save :strip_inputs
  
  def strip_inputs
    self.name = self.name.strip.downcase
  end
  
  def count
    self.projects.size
  end
  
  def self.top_tags
    includes(:projects).sort_by { |tag| tag.projects.size }.reverse
  end
end
