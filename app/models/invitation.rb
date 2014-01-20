class Invitation < ActiveRecord::Base
  attr_accessible :email, :user_id, :email_group, :message
  belongs_to :user
  
  validates :email, presence: true, :uniqueness => {:scope => :user_id}
  validates :user_id, presence: true
  
  before_save { self.email.downcase! }
end
