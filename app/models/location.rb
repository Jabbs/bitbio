class Location < ActiveRecord::Base
  attr_accessible :address1, :address2, :address3, :city, :country, :state, :zip, :latitude,
                  :longitude
  belongs_to :locationable, polymorphic: true
  
  geocoded_by :full_address
  
  after_validation :geocode, :if => :address1_changed?
  after_validation :geocode, :if => :address2_changed?
  after_validation :geocode, :if => :address3_changed?
  after_validation :geocode, :if => :city_changed?
  after_validation :geocode, :if => :state_changed?
  after_validation :geocode, :if => :zip_changed?
  after_validation :geocode, :if => :country_changed?
  
  def full_address
    "#{address1}, #{address2}, #{address3}, #{city}, #{state}, #{zip}, #{country}"
  end
end
