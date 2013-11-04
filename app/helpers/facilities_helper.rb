module FacilitiesHelper
  
  def city_state_zip_country(location)
    x = []
    x << location.city if location.city && !location.city.empty?
    x << location.state if location.state && !location.state.empty?
    x << location.zip if location.zip && !location.zip.empty?
    x << location.country if location.country && !location.country.empty?
    x.join(', ')
  end
end
