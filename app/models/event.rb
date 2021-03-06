class Event < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]
  attr_accessible :description, :end_date, :location_name, :organizer, :phone, :start_date, :title, :twitter_handle, :website,
                  :user_id, :tag_list, :location_attributes, :attachments_attributes, :_destroy
  attr_accessor   :_destroy
                 
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings
  has_one :location, as: :locationable, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  accepts_nested_attributes_for :attachments, allow_destroy: true
  accepts_nested_attributes_for :location, allow_destroy: true
  accepts_nested_attributes_for :taggings, allow_destroy: true
  
  validates :title, presence: true, uniqueness: true
  validates :user_id, presence: true
  validates :description, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  
  def self.featured
    Event.where(approved: true).where("start_date > ?", Date.today).order("start_date ASC").first(6)
  end
  
  def self.tagged_with(name)
    Tag.find_by_name(name).events if Tag.find_by_name(name)
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
  
  def add_view_count
    self.view_count += 1
    save
  end
end
