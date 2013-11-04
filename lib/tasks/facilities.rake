require 'csv'

namespace :db do
  desc 'Populate database with facilities'
  task :populate_facilities => :environment do
    CSV.foreach('lib/assets/facilities.csv', headers: true, :encoding => 'windows-1251:utf-8') do |row|
      name          = row[0]
      address1      = row[2]
      address2      = row[3]
      address3      = row[4]
      city          = row[5]
      state         = row[6]
      zip           = row[7]
      country       = row[8]
      phone         = row[9]
      website       = row[10]
      email         = row[11]
      provider      = row[12]
      
      facility = Facility.new(name: name, phone: phone, website: website, email: email)
      facility.build_location(address1: address1, address2: address2, address3: address3, city: city,
                            state: state, zip: zip, country: country)
      facility.save
    end
    
    CSV.foreach('lib/assets/facilities2.csv', headers: true, :encoding => 'windows-1251:utf-8') do |row|
      name          = row[0]
      country       = row[1]
      
      facility = Facility.new(name: name)
      facility.build_location(country: country, display_on_map: false)
      facility.save
    end
  end
  
end
