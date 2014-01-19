class Invitation < ActiveRecord::Base
  attr_accessible :email, :user_id, :email_group, :message
  belongs_to :user
end
