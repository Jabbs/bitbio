class Service < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
  
  attr_accessible :description, :name, :tag_list, :visability, :expiration_date, :resources_attributes
  
  VISABILITY_OPTIONS = ["public", "private", "locked"]
  
  # callbacks
  after_validation :move_friendly_id_error_to_name
  before_save :strip_inputs
  
  # validations
  validates :description, presence: true, length: { minimum: 90, maximum: 2000 }
  validates :visability, presence: true, inclusion: { in: VISABILITY_OPTIONS, message: "%{value} isn't an allowed option" }
  validates :name, presence: true
  
  belongs_to :user
  has_many :resources
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings
  accepts_nested_attributes_for :taggings, allow_destroy: true
  accepts_nested_attributes_for :resources, allow_destroy: true
  
  def self.search(any=nil, na=nil, eur=nil, asia=nil, aus=nil, science=nil, tag=nil)
    services = self.scoped
    unless science.blank? || science == nil
      services = services.joins(:resources).where(resources: {name: science})
    end
    unless tag.blank? || tag == nil
      services = services.joins(:tags).where(tags: {name: tag})
    end

    unless any.present? && any == 'yes'
      continents = []
      unless na.blank? || na == nil
        continents << "North America" if na == 'yes'
      end
      unless eur.blank? || eur == nil
        continents << "Europe" if eur == 'yes'
      end
      unless asia.blank? || asia == nil
        continents << "Asia" if asia == 'yes'
      end
      unless aus.blank? || aus == nil
        continents << "Australia" if aus == 'yes'
      end
    
      services = services.joins(:user).where(users: {continent: continents})
    end
    services
  end
  
  def add_view_count
    self.view_count += 1
    save
  end
  
  def country
    user.country
  end
  
  def strip_inputs
    self.name = self.name.strip
  end
  
  def self.tagged_with(name)
    Tag.find_by_name(name).services if Tag.find_by_name(name)
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
  
  def inactive?
    !self.active?
  end
  
  def move_friendly_id_error_to_name
    errors.add :name, *errors.delete(:friendly_id) if errors[:friendly_id].present?
  end
  
  def add_view_count
    self.view_count += 1
    save
  end
end
