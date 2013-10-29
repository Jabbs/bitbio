class ConnectionRequest < ActiveRecord::Base
  attr_accessible :receiver_id, :sender_id
  
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  
  validates :receiver_id, presence: true, :uniqueness => {:scope => :sender_id}
  validates :sender_id, presence: true, :uniqueness => {:scope => :receiver_id}
  
  before_create { generate_token(:connection_token) }
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while ConnectionRequest.exists?(column => self[column])
  end
  
  def send_new_connection_request_email
    UserMailer.new_connection_request_email(self).deliver
    self.new_connection_request_email_sent_at = Time.zone.now
    self.save!
  end
end
