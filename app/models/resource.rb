class Resource < ActiveRecord::Base
  attr_accessible :kind, :name, :note, :service_id, :quantity, :price, :unit_type, :currency_type
  
  belongs_to :service
  
  validates :kind, presence: true
  validates :name, presence: true, uniqueness: { scope: :service_id}
  
end
