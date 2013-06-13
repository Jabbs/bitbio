class Facility < ActiveRecord::Base
  attr_accessible :name
  
  has_many :labs
  has_many :users
  validates :name, uniqueness: true
end
