class Tag < ActiveRecord::Base
  attr_accessible :name
  has_many :taggings, dependent: :destroy
  
  has_many :projects, through: :taggings, :source => :taggable, :source_type => 'Project'
  has_many :blogs, through: :taggings, :source => :taggable, :source_type => 'Blog'
  
  validates :name, presence: true, uniqueness: true
  before_save :strip_inputs
  
  def strip_inputs
    self.name = self.name.strip.downcase
  end
  
  def self.top_project_tags
    includes(:projects).sort_by { |tag| tag.projects.size }.reverse.select { |t| t.projects.size != 0 }
  end
  
  def self.top_blog_tags
    includes(:blogs).sort_by { |tag| tag.blogs.size }.reverse.select { |t| t.blogs.size != 0 }
  end
end
