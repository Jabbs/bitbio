class Resource < ActiveRecord::Base
  attr_accessible :kind, :name, :note, :service_id, :quantity, :price, :unit_type, :currency_type
  
  belongs_to :service
  
  validates :kind, presence: true
  validates :name, presence: true, uniqueness: { scope: :service_id}
  SERVICE_TYPES = ["Instrument", "Software", "Method", "Reagent", "Experiment", "Other"]
  
  scope :instruments, ->() { where(kind: 'Instrument') }
  scope :softwares, ->() { where(kind: 'Software') }
  scope :all_methods, ->() { where(kind: 'Method') }
  scope :reagents, ->() { where(kind: 'Reagent') }
  scope :experiments, ->() { where(kind: 'Experiment') }
  
end
