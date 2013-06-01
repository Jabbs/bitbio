class Comment < ActiveRecord::Base
  attr_accessible :content, :project_id, :user_id
  belongs_to :user
  belongs_to :project
  validates :content, presence: true
  
  def send_new_comment_email
    UserMailer.new_comment_email(self).deliver
    self.new_comment_email_sent_at = Time.zone.now
    self.save!
  end
end
