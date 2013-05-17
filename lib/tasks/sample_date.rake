namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    
    unless User.find_by_email('petejabbour1@gmail.com')
      User.create!(first_name: 'Peter', last_name: 'Jabbour', email: 'petejabbour1@gmail.com', password: 'testing', password_confirmation: 'testing',
                   account_type: 'Researcher', organization: 'The Stowers Institute', phone: '785-550-8670',
                   description: Faker::Lorem.paragraph)
    end
    
    40.times do
      User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, 
                    password: 'testing', password_confirmation: 'testing', account_type: ['Researcher', 'Provider'].shuffle.first, 
                    organization: Faker::Company.name, phone: Faker::PhoneNumber.phone_number, description: Faker::Lorem.paragraph)
    end
    
    20.times do
      name = ['Human', 'Rat', 'Fly', 'Mouse'].shuffle.first + " " + ['DNA', 'Genome', 'RNA', 'Ribosome', 'Histone'].shuffle.first + " " + ['Sequencing', 'Analysis', 'Experiment', 'Research', 'Study'].shuffle.first
      description = Faker::Lorem.paragraph + ' ' + Faker::Lorem.paragraph
      science_type = ['DNA Sequencing', 'RNA Sequencing', 'Chip-SEQ', 'Micro Array', 'Next-gen Sequencing',
                      'Microscopy', 'Cytometry'].shuffle.first
      service_need = ['Science', 'Services', 'Science + Services', 'Data Analysis'].shuffle.first
      start_date = rand(300).days.from_now.to_date
      project = Project.new(name: name, description: description, science_type: science_type, service_need: service_need,
                            start_date: start_date)
      project.user_id = User.where(account_type: 'Researcher').shuffle.first.id
      project.save!
    end
  end
end