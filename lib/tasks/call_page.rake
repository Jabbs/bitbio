desc "This task is made to prevent 1 dyno idling"
task :call_page => :environment do
  uri = URI.parse('http://www.bitbio.co')
  Net::HTTP.get(uri)
end