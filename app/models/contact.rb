class Contact < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :user_type
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
end
