class Like < ActiveRecord::Base
  attr_accessible :likeable_id, :likeable_type, :user_id
  
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  validates :user_id, presence: true, uniqueness: { scope: [:likeable_id, :likeable_type] }

end
