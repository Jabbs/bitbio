class Instrument < ActiveRecord::Base
  attr_accessible :alias, :project_id
  belongs_to :project
  validates :alias, presence: true
  validates_uniqueness_of :alias, scope: :project_id
end
