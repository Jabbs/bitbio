class Comment < ActiveRecord::Base
  attr_accessible :content, :project_id, :user_id
  belongs_to :user
  belongs_to :project
  validates :content, presence: true
end
