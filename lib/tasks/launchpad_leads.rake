require 'csv'

namespace :db do
  desc 'Populate contacts with launchpad leads'
  task :populate_launchpad_contacts => :environment do
    CSV.foreach('lib/assets/launchpad_leads.csv', headers: true, :encoding => 'windows-1251:utf-8') do |row|
      full_name      = row[0]
      email          = row[1]
      first_name = full_name.split[0].titleize if full_name.split[0]
      last_name = full_name.split[1].titleize if full_name.split[1]
      
      unless Contact.find_by_email(email)
        Contact.create!(email: email, first_name: first_name, last_name: last_name)
      end
    end
  end
  
end