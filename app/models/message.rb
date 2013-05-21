class Message < ActiveRecord::Base
  attr_accessible :content, :receiver_id, :sender_id, :project_id, :title
  
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  
  validates :content, presence: true
  validates :receiver_id, presence: true
  validates :sender_id, presence: true
end
