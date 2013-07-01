require 'csv'

namespace :db do
  desc 'Populate database with resources'
  task :populate_resources => :environment do
    CSV.foreach('lib/assets/resources.csv', headers: true, :encoding => 'windows-1251:utf-8') do |row|
      name = row[0]
      kind = row[1]
      
      unless Resource.find_by_name(name)
        Resource.create!(name: name, kind: kind)
      end
    end
  end
  
end