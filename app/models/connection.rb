class Connection < ActiveRecord::Base
  attr_accessible :connected_id, :connecter_id
  
  belongs_to :connecter, class_name: "User"
  belongs_to :connected, class_name: "User"
  
  validates :connecter_id, presence: true
  validates :connected_id, presence: true
end
