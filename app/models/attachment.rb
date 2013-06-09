class Attachment < ActiveRecord::Base
  require 'carrierwave/orm/activerecord'
  attr_accessible :image
  belongs_to :attachable, polymorphic: true
  mount_uploader :image, ImageUploader
end
