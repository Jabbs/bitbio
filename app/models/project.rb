class Project < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
  attr_accessible :description, :name, :science_type, :service_need, :start_date
  
  TYPES = ['Service', 'Science', 'Service + Science', 'Data Analysis']
  
  belongs_to :user
  has_many :comments
  
  validates :description, presence: true, length: { minimum: 90, maximum: 2000 }
  validates :science_type, presence: true
  validates :name, presence: true, uniqueness: true
  after_validation :move_friendly_id_error_to_name

  def move_friendly_id_error_to_name
    errors.add :name, *errors.delete(:friendly_id) if errors[:friendly_id].present?
  end
  
  def self.search(keyword=nil, from=nil, to=nil, country=nil, science=nil)
    projects = self.scoped
    unless keyword.blank? || keyword == nil
      projects = projects.where("name LIKE ? OR description LIKE ? OR science_type LIKE ?", "%#{keyword}%","%#{keyword}%","%#{keyword}%")
    end
    unless science.blank? || science == nil
      projects = projects.where("science_type LIKE ?", "%#{science}%")
    end
    unless country.blank? || country == nil
      projects = projects.joins(:user).where(users: {country: country})
    end
    unless from == nil || to == nil || from.blank? || to.blank?
      projects = projects.where(start_date: ( from..to) )
    end
    projects
  end
  
  def country
    user.country
  end
  
end
