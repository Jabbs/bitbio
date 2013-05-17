class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :full_name, use: [:slugged, :history]
  attr_accessible :account_type, :description, :email, :first_name, :last_name, :organization,
                  :password, :password_confirmation, :phone
  has_secure_password
  
  validates :first_name, presence: true, length: { maximum: 30 }
  validates :last_name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password_confirmation, presence: true, on: :create
  
  before_save { self.email.strip.downcase! }
  before_save { self.first_name.strip.capitalize! }
  before_save { self.last_name.strip.capitalize! }
  before_create { generate_token(:auth_token) }
  
  has_many :projects
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
  def full_name
    self.first_name + " " + self.last_name
  end
end
