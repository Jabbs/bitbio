class Resource < ActiveRecord::Base
  attr_accessible :kind, :name, :note, :service_id, :quantity, :price, :unit_type, :currency_type
  
  belongs_to :service
  
  validates :kind, presence: true
  validates :name, presence: true, uniqueness: { scope: :service_id}
  
  SERVICE_TYPES = ["Instrument", "Software", "Method", "Reagent", "Experiment", "Other"]
  UNIT_TYPES = ["Sample", "Reaction", "Unit", "Run", "Analysis"]
  
  scope :instruments, ->() { where(kind: 'Instrument') }
  scope :softwares, ->() { where(kind: 'Software') }
  scope :all_methods, ->() { where(kind: 'Method') }
  scope :reagents, ->() { where(kind: 'Reagent') }
  scope :experiments, ->() { where(kind: 'Experiment') }
  scope :others, ->() { where(kind: 'Other') }
  
  def pricing?
    if self.price && self.unit_type && self.currency_type
      true
    else
      false
    end
  end
  
end
