class Blog < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]
  attr_accessible :body, :title, :user_id, :tag_list
  
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :tags, through: :taggings
  accepts_nested_attributes_for :taggings, allow_destroy: true
  
  validates :user_id, presence: true
  validates :title, presence: true, uniqueness: true
  validates :body, presence: true
  
  def self.tagged_with(name)
    Tag.find_by_name(name).blogs if Tag.find_by_name(name)
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
      joins(:taggings).group("taggings.tag_id")
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
  
  def self.featured
    Blog.where(featured: true)
  end
  
  def add_view_count
    self.view_count += 1
    save
  end
end
