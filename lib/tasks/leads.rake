require 'csv'

namespace :db do
  desc 'Populate database with leads'
  task :populate_leads => :environment do
    CSV.foreach('lib/assets/leads.csv', headers: true, :encoding => 'windows-1251:utf-8') do |row|
      email          = row[0]
      first_name     = row[1]
      last_name      = row[2]
      full_name      = row[3]
      organization   = row[4]
      department     = row[5]
      country        = row[6]
      phone          = row[7]
      type           = row[8]
      notes          = row[9]
      title          = row[10]

      lead = Lead.new(email: email, first_name: first_name, last_name: last_name, organization: organization,
                   department: department, country: country, phone: phone, type: type, notes: notes,
                   title: title)
      lead.save
    end
  end
  
end