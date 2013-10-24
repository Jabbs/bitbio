class Lead < ActiveRecord::Base
  attr_accessible :country, :department, :email, :first_name, :full_name, :last_name, :notes, 
                  :organization, :phone, :title, :type
  
  validates :email, presence: true, uniqueness: true
end
