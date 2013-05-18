class Project < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
  attr_accessible :description, :name, :science_type, :service_need, :start_date
  
  TYPES = ['Service', 'Science', 'Service + Science', 'Data Analysis']
  
  belongs_to :user
  
  validates :description, presence: true, length: { minimum: 90, maximum: 2000 }
  validates :science_type, presence: true
  validates :name, presence: true, uniqueness: true
  after_validation :move_friendly_id_error_to_name

  def move_friendly_id_error_to_name
    errors.add :name, *errors.delete(:friendly_id) if errors[:friendly_id].present?
  end
  
  def self.search(search, from, to)
    if search
      find(:all, conditions: ['name LIKE ?', "%#{search}%"])
      where(start_date: ( from..to) ) unless from.blank? || to.blank?
    else
      find(:all)
    end
  end
  
end
