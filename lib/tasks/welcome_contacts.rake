desc "Notify all the contacts of BitBio"
task :welcome_contacts => :environment do
  Contact.all.each do |contact|
    UserMailer.welcome_email(contact).deliver
  end
end