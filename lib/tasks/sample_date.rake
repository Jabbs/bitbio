namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    
    unless User.find_by_email('petejabbour1@gmail.com')
      user = User.new(first_name: 'Peter', last_name: 'Jabbour', email: 'petejabbour1@gmail.com', password: 'testing', password_confirmation: 'testing',
                   account_type: 'Researcher', organization: 'The Stowers Institute', phone: '785-550-8670',
                   bio: Faker::Lorem.paragraph, address: "3049 W Fullerton #1", city: "Chicago",
                   state: "IL", zip: "60647", country: "United States of America")
      user.verified = true
      user.save!
    end
    
    40.times do
      user = User.new(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, 
                    password: 'testing', password_confirmation: 'testing', account_type: ['Researcher', 'Provider'].shuffle.first, 
                    organization: Faker::Company.name, phone: Faker::PhoneNumber.phone_number, bio: Faker::Lorem.paragraph,
                    address: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state_abbr,
                    zip: Faker::Address.zip_code, country: Ravibhim::Continents::COUNTRIES.shuffle.first)
      user.verified = true
      user.save!
    end
    
    100.times do
      name = ['Human', 'Rat', 'Fly', 'Mouse', 'Zebra Fish', 'Yeast', 'Lizard'].shuffle.first + " " + ['DNA', 'Genome', 'RNA', 'Ribosome', 'Histone'].shuffle.first + " " + ['Sequencing', 'Analysis', 'Experiment', 'Research', 'Study'].shuffle.first + " " + ('a'..'z').to_a.shuffle.first(8).join
      description = Faker::Lorem.paragraph + ' ' + Faker::Lorem.paragraph + ' ' + Faker::Lorem.paragraph + ' ' + Faker::Lorem.paragraph
      science_type = ['DNA Sequencing', 'RNA Sequencing', 'Chip-SEQ', 'Micro Array', 'Next-gen Sequencing',
                      'Microscopy', 'Cytometry'].shuffle.first
      service_need = Project::SERVICE_NEEDS.shuffle.first
      start_date = rand(300).days.from_now.to_date
      exp_date = Date.today + [30, 90, 180].shuffle.first.days
      project = Project.new(name: name, description: description, science_type: science_type, service_need: service_need,
                            start_date: start_date, expiration_date: exp_date)
      project.user_id = User.all.shuffle.first.id
      
      x = rand(1..3).to_i
      Project::SCIENCE_EQUIPMENT.uniq.shuffle[0..x].each do |i|
        instrument = project.instruments.build(alias: i)
        instrument.must_have = [true, false].shuffle.first
        instrument.save
      end
      Project::TAGS.uniq.shuffle[0..x].each do |tag|
        if Tag.find_by_name(tag)
          t = Tag.find_by_name(tag)
        else
          t = Tag.create!(name: tag)
        end
        project.taggings.build(project_id: project.id, tag_id: t.id)
        project.save!
      end
      project.view_count = rand(0..200)
      project.save!
    end
    
    200.times do
      Comment.create!(content: Faker::Lorem.paragraph, project_id: Project.all.shuffle.first.id,
                      user_id: User.all.shuffle.first.id)
      
    end
    
    80.times do
      project = Project.all.shuffle.first
      subject = "Project - #{project.name}"
      Message.create!(content: Faker::Lorem.paragraph, project_id: Project.all.shuffle.first.id,
                      sender_id: User.where(verified: true).shuffle.first.id,
                      receiver_id: project.user.id, project_id: project.id,
                      subject: subject)
      
    end
  end
end