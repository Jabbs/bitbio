class Project < ActiveRecord::Base
  attr_accessible :description, :name, :science_type, :service_need
  
  TYPES = ['Next Gen', 'Micro Array', 'Microscopy']
  
  belongs_to :user
end
