class Location < ActiveRecord::Base
  attr_accessible :address1, :address2, :address3, :city, :country, :state, :zip, :latitude,
                  :longitude
  belongs_to :locationable, polymorphic: true
  
  geocoded_by :full_address
  acts_as_gmappable :process_geocoding => false
  
  after_validation :geocode, :if => :address1_changed?
  after_validation :geocode, :if => :address2_changed?
  after_validation :geocode, :if => :address3_changed?
  after_validation :geocode, :if => :city_changed?
  after_validation :geocode, :if => :state_changed?
  after_validation :geocode, :if => :zip_changed?
  after_validation :geocode, :if => :country_changed?
  
  scope :facilities, ->() { where(locationable_type: 'Facility') }
  
  def full_address
    "#{address1}, #{address2}, #{address3}, #{city}, #{state}, #{zip}, #{country}"
  end
  
  def gmaps4rails_address
  # describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{address1}, #{address2}, #{address3}, #{city}, #{state}, #{zip}, #{country}"
  end

end
