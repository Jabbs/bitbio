class Tagging < ActiveRecord::Base
  attr_accessible :project_id, :tag_id
  belongs_to :tag
  belongs_to :project
end
