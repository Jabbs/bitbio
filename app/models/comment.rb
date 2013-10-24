class Comment < ActiveRecord::Base
  attr_accessible :content, :user_id, :parent_id
  has_ancestry
  
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :likes, as: :likeable, dependent: :destroy
  
  validates :content, presence: true
  validates :user_id, presence: true
  
  def send_new_comment_email
    UserMailer.new_comment_email(self).deliver
    self.new_comment_email_sent_at = Time.zone.now
    self.save!
  end
end
