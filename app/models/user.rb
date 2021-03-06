class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :full_name, use: [:slugged, :history]
  attr_accessible :account_type, :bio, :email, :first_name, :last_name, :password, :password_confirmation, 
                  :phone, :country, :membership, :continent, :attachments_attributes, :_destroy,
                  :facility_id, :lab_id, :organization, :project_alerts, :blog_alerts, :event_alerts,
                  :subscribed, :newsletter, :title, :tw_url, :li_url, :website, :interest_description,
                  :mend_url, :fb_url
  attr_accessor   :_destroy
  has_secure_password
  
  # callbacks
  before_validation :update_continent
  before_save :correct_case_of_inputs
  before_save :check_to_resubscribe_user, on: :update
  before_save :check_if_organization_changed, on: :update
  before_create { generate_token(:auth_token) }
  before_create { generate_token(:verification_token) }
  before_create { generate_number_token(:invite_token) }
  
  # validations
  validates :first_name, presence: true, length: { maximum: 40 }
  validates :last_name, presence: true, length: { maximum: 40 }
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, :with => /@/
  validates :organization, presence: true
  validates :country, presence: true
  validates :password, presence: true, on: :create
  
  # associations
  belongs_to :lab
  belongs_to :facility
  has_many :sent_messages, foreign_key: "sender_id", class_name: "Message"
  has_many :received_messages, foreign_key: "receiver_id", class_name: "Message"
  has_many :message_receivers, through: :sent_messages, source: :receiver
  has_many :message_senders, through: :received_messages, source: :sender
  has_many :projects, dependent: :destroy
  has_many :comments
  has_many :likes
  has_many :services
  has_many :events
  has_many :blogs, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  accepts_nested_attributes_for :attachments, allow_destroy: true
  has_many :connection_requests, foreign_key: "sender_id", dependent: :destroy
  has_many :reverse_connection_requests, foreign_key: "receiver_id", class_name: "ConnectionRequest", dependent: :destroy
  has_many :connections, foreign_key: "connecter_id", dependent: :destroy
  has_many :reverse_connections, foreign_key: "connected_id", class_name: "Connection", dependent: :destroy
  has_many :connected_users, through: :connections, source: :connected
  has_many :connecter_users, through: :reverse_connections, source: :connecter
    
  def check_to_resubscribe_user
    if self.subscribed == false
      if self.project_alerts_was == false && self.project_alerts_changed?
        self.update_attribute(:subscribed, true)
      elsif self.blog_alerts_was == false && self.blog_alerts_changed?
        self.update_attribute(:subscribed, true)
      elsif self.newsletter_was == false && self.newsletter_changed?
        self.update_attribute(:subscribed, true)
      elsif self.event_alerts_was == false && self.event_alerts_changed?
        self.update_attribute(:subscribed, true)
      end
    end
  end
  
  def check_if_organization_changed
    if self.organization_changed?
      if facility = Facility.find_by_name(self.organization)
      else
        facility = Facility.new(name: self.organization)
        facility.build_location(country:  self.country, display_on_map: false)
        facility.save
      end
      self.facility_id = facility.id
    end
  end
  
  def self.featured
    User.last(3)
  end
  
  def all_connection_users
    (self.connected_users + self.connecter_users).sort_by{|e| e[:last_name]}
  end
  
  def connection_users_limit_nine
    connections = self.all_connection_users
    connections.shuffle.take(9)
  end
  
  def number_of_connections
    self.connected_users.size + self.connecter_users.size
  end
  
  def has_links?
    if self.tw_url.blank? && self.li_url.blank? && self.website.blank? && self.mend_url.blank? && self.fb_url.blank?
      false
    else
      true
    end
  end
  
  def has_social_links?
    if self.tw_url.blank? && self.li_url.blank? && self.mend_url.blank? && self.fb_url.blank?
      false
    else
      true
    end
  end
  
  def connected_with(user)
    if user.all_connection_users.include?(self)
      true
    else
      false
    end
  end
  
  def update_continent
    self.continent = Ravibhim::Continents.get_continent(self.country)
  end
  
  def correct_case_of_inputs
    self.email = self.email.strip.downcase
    self.first_name = self.first_name.strip.capitalize
    self.last_name = self.last_name.strip.capitalize
    self.organization = self.organization.strip
  end
  
  def new_message_count
    self.received_messages.unviewed.size
  end
  
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset_email(self).deliver
  end
  
  def add_to_sign_in_attributes(request_ip)
    self.sign_in_count += 1
    self.last_sign_in_at = Time.now
    self.last_sign_in_ip = request_ip
    self.save
  end
  
  def send_verification_email
    generate_token(:verification_token)
    self.verification_sent_at = Time.zone.now
    save!
    UserMailer.verification_email(self).deliver
  end
  
  def contacts
    (self.message_receivers + self.message_senders).uniq
  end
  
  def researcher?
    account_type == "Researcher" ? true : false
  end
  
  def provider?
    account_type == "Provider" ? true : false
  end
  
  def full_address
    "#{address}, #{city}, #{state} #{zip}"
  end
  
  def full_address_present?
    if address? && city? && state? && zip?
      true
    else
      false
    end
  end
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
  def generate_number_token(column)
    begin
      self[column] = ('1'..'9').to_a.shuffle[0,5].join
    end while User.exists?(column => self[column])
  end
  
  def full_name
    self.first_name + " " + self.last_name
  end
  
  def full_name_w_account_type
    self.full_name + " - " + self.account_type
  end
  
end
