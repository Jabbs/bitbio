require 'csv'

namespace :db do
  desc 'Populate database with leads'
  task :split_protocols => :environment do
    x = []
    CSV.foreach('lib/assets/protocols.csv', :encoding => 'windows-1251:utf-8') do |row|
      unsplit_protocol = row[0]
      marker1 = ">"
      marker2 = "</option>"
      protocol = unsplit_protocol[/#{Regexp.escape(marker1)}(.*?)#{Regexp.escape(marker2)}/m, 1]
      protocol.strip
      x << protocol
    end
    print x
  end
  
end
