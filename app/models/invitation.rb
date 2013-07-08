class Invitation < ActiveRecord::Base
  attr_accessible :email, :user_id, :email_group
  belongs_to :user
end
