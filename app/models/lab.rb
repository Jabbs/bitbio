class Lab < ActiveRecord::Base
  attr_accessible :facility_id, :name
  belongs_to :facility
  has_many :users
  validates :name, :uniqueness => {:scope => :facility_id}
end
