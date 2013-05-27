class Message < ActiveRecord::Base
  attr_accessible :content, :receiver_id, :sender_id, :project_id, :subject
  
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  
  validates :content, presence: true
  validates :receiver_id, presence: true
  validates :sender_id, presence: true
  validates :subject, presence: true
  
  # scopes
  scope :unviewed, ->() { where(viewed: false) }
  
  def view_message
    self.viewed = true
    save
  end
  
  def send_new_message_email
    UserMailer.new_message_email(self).deliver
    self.new_message_email_sent_at = Time.zone.now
    self.save!
  end
  
end
