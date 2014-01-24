class Contact < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :user_type
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  
  CONTACTS_FROM_LEADS_LIST = ["artem.khlebnikov@bioaster.com", "pietro.piffanelli@tecnoparco.org", "dk@waksman.rutgers.edu", "palma.leopoldo@gmail.com", "ysl0928@gmail.com", "bhampton@som.umaryland.edu", "rvoelker@uoregon.edu", "nvthuyne@gmail.com", "a.ferrero@acgen.es", "jeff@yunes.us", "dtorti26@gmail.com", "jharness@gmail.com"]
  
  def full_name
    self.first_name + " " + self.last_name
  end
end
