class Facility < ActiveRecord::Base
  attr_accessible :name, :website, :email, :phone, :location_attributes
  
  has_many :labs
  has_many :users
  validates :name, uniqueness: true
  
  has_one :location, as: :locationable, dependent: :destroy
  accepts_nested_attributes_for :location, allow_destroy: true
end
