class Instrument < ActiveRecord::Base
  attr_accessible :alias, :project_id, :must_have, :resource_type
  belongs_to :project
  validates :alias, presence: true
  validates_uniqueness_of :alias, scope: :project_id
end
