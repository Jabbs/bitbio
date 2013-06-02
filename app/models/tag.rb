class Tag < ActiveRecord::Base
  attr_accessible :name
  has_many :taggings
  has_many :projects, through: :taggings
  
  def count
    self.projects.size
  end
  
  def self.top_tags
    includes(:projects).sort_by { |tag| tag.projects.size }.reverse
  end
end
