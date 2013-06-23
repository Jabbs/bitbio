module FacilitiesHelper
  
  def city_state_zip_country(location)
    x = []
    x << location.city if location.city
    x << location.state if location.state
    x << location.zip if location.zip
    x << location.country if location.country
    x.join(', ')
  end
end
