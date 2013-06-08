class Comment < ActiveRecord::Base
  attr_accessible :content, :user_id
  
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  
  validates :content, presence: true
  validates :user_id, presence: true
  
  def send_new_comment_email
    UserMailer.new_comment_email(self).deliver
    self.new_comment_email_sent_at = Time.zone.now
    self.save!
  end
end
