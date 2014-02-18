desc "Send newsletter1 all the contacts of BitBio"
task :newsletter1 => :environment do
  Contact.all.each do |contact|
    UserMailer.newsletter_email(contact).deliver
  end
end