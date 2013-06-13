namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    
    40.times do 
      name = Faker::Company.name + " " + ["Facility", "Center", "Institute", "University", "Hospital"].shuffle.first
      Facility.create(name: name)
    end
    
    60.times do
      name = Faker::Name.last_name + " Lab"
      Facility.all.shuffle.first.labs.create(name: name)
    end
    
    unless User.find_by_email('petejabbour1@gmail.com')
      lab = Lab.all.shuffle.first
      facility = lab.facility
      user = User.new(first_name: 'Peter', last_name: 'Jabbour', email: 'petejabbour1@gmail.com', password: 'testing', password_confirmation: 'testing',
                   account_type: 'Researcher', facility_id: facility.id, lab_id: lab.id, phone: '785-550-8670',
                   bio: Faker::Lorem.paragraph, address: "3049 W Fullerton #1", city: "Chicago",
                   state: "IL", zip: "60647", country: "United States of America", organization: facility.name)
      user.verified = true
      user.save!
    end
    
    40.times do
      lab = Lab.all.shuffle.first
      facility = lab.facility
      user = User.new(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, 
                    password: 'testing', password_confirmation: 'testing', account_type: ['Researcher', 'Provider'].shuffle.first, 
                    lab_id: lab.id, facility_id: facility.id, phone: Faker::PhoneNumber.phone_number, bio: Faker::Lorem.paragraph,
                    address: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state_abbr,
                    zip: Faker::Address.zip_code, country: Ravibhim::Continents::COUNTRIES.shuffle.first, organization: facility.name)
      user.verified = true
      user.save!
    end
    
    100.times do
      name = ['Human', 'Rat', 'Fly', 'Mouse', 'Zebra Fish', 'Yeast', 'Lizard'].shuffle.first + " " + ['DNA', 'Genome', 'RNA', 'Ribosome', 'Histone'].shuffle.first + " " + ['Sequencing', 'Analysis', 'Experiment', 'Research', 'Study'].shuffle.first + " " + ('a'..'z').to_a.shuffle.first(8).join
      description = Faker::Lorem.paragraph + ' ' + Faker::Lorem.paragraph + ' ' + Faker::Lorem.paragraph + ' ' + Faker::Lorem.paragraph
      science_type = ['DNA Sequencing', 'RNA Sequencing', 'Chip-SEQ', 'Micro Array', 'Next-gen Sequencing',
                      'Microscopy', 'Cytometry'].shuffle.first
      service_need = Project::SERVICE_NEEDS.shuffle.first
      start_date = [7,20,25,30,34,40,80,90,100,123,44,2,234,300,23,10,50].shuffle.first.days.from_now.to_date
      exp_date = Date.today + [30, 90, 180].shuffle.first.days
      project = Project.new(name: name, description: description, science_type: science_type, service_need: service_need,
                            start_date: start_date, expiration_date: exp_date)
      project.user_id = User.all.shuffle.first.id
      
      x = [1,2,3].shuffle.first
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
        project.taggings.build(tag_id: t.id)
        project.save!
      end
      project.view_count = [7,20,25,30,34,40,80,90,100,123,44,2,234,300,23,10,50].shuffle.first
      project.save!
    end
    
    100.times do
      name = ['Illumina', 'Roche', 'Life Sciences', 'PacBio', 'Complete Genomics', 'Agilent', 'Thermo Fisher'].shuffle.first + " " + ['Next-gen', 'Microarray', 'Biochemical', 'Protein', 'DNA'].shuffle.first + " " + ['Sequencing', 'Analysis', 'Experiment', 'Research', 'Study'].shuffle.first + " " + ('a'..'z').to_a.shuffle.first(8).join
      description = Faker::Lorem.paragraph + ' ' + Faker::Lorem.paragraph + ' ' + Faker::Lorem.paragraph + ' ' + Faker::Lorem.paragraph
      service_type = Service::SERVICE_TYPES.shuffle.first
      price = [1000, 200, 12, 40, 99, 300, 1200, 1100, 100, 300, 400, 500, 3100, 800].shuffle.first
      unit_type = Service::UNIT_TYPES.shuffle.first
      exp_date = Date.today + [30, 90, 180].shuffle.first.days
      service = Service.new(name: name, description: description, service_type: service_type, price: price,
                            unit_type: unit_type, expiration_date: exp_date)
      service.user_id = User.all.shuffle.first.id
      
      x = [1,2,3].shuffle.first
      Project::TAGS.uniq.shuffle[0..x].each do |tag|
        if Tag.find_by_name(tag)
          t = Tag.find_by_name(tag)
        else
          t = Tag.create!(name: tag)
        end
        service.taggings.build(tag_id: t.id)
        service.save!
      end
      service.view_count = [7,20,25,30,34,40,80,90,100,123,44,2,234,300,23,10,50].shuffle.first
      service.save!
    end
    
    80.times do
      project = Project.all.shuffle.first
      subject = "Project - #{project.name}"
      Message.create!(content: Faker::Lorem.paragraph, project_id: Project.all.shuffle.first.id,
                      sender_id: User.where(verified: true).shuffle.first.id,
                      receiver_id: project.user.id, project_id: project.id,
                      subject: subject)
      
    end
    
    30.times do
      user = User.all.shuffle.first
      body = Faker::Lorem.paragraph + Faker::Lorem.paragraph + Faker::Lorem.paragraph + Faker::Lorem.paragraph + Faker::Lorem.paragraph
      blog = user.blogs.build(title: Faker::Lorem.sentence, body: body)
      blog.view_count = [7,20,25,30,34,40,80,90,100,123,44,2,234,300,23,10,50].shuffle.first
      x = [1,2,3].shuffle.first
      Project::TAGS.uniq.shuffle[0..x].each do |tag|
        if Tag.find_by_name(tag)
          t = Tag.find_by_name(tag)
        else
          t = Tag.create!(name: tag)
        end
        blog.taggings.build(tag_id: t.id)
        blog.save!
      end
      blog.save!
    end
    
    100.times do
      Blog.all.shuffle.first.comments.create!(content: Faker::Lorem.paragraph, user_id: User.all.shuffle.first.id)
    end
    200.times do
      Project.all.shuffle.first.comments.create!(content: Faker::Lorem.paragraph, user_id: User.all.shuffle.first.id)
    end
  end
end