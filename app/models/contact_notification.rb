class ContactNotification < ActiveRecord::Base
  attr_accessible :action, :contact_id, :email_sent_at
  
  belongs_to :contact
end
