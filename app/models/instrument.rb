class Instrument < ActiveRecord::Base
  attr_accessible :name, :project_id
  belongs_to :project
  validates :name, presence: true
  validates_uniqueness_of :name, scope: :project_id
end
