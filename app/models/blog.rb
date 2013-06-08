class Blog < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]
  attr_accessible :body, :title, :user_id
  
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  
  validates :user_id, presence: true
  
  def add_view_count
    self.view_count += 1
    save
  end
end
