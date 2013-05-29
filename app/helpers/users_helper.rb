module UsersHelper
  
  def country_with_us_shortened(country)
    country = "United States" if country == "United States of America"
    country
  end
end
