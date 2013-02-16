namespace :injest do
  task :people => :environment do
    people = []
    updated_count = 0
    created_count = 0
    JobList.all.each do |job_list|
      puts "Injesting #{job_list.job_title} from #{job_list.url}"
      scraped = job_list.scrape_people
      puts "Found #{scraped.size} people in job"
      scraped.each do |key, value|
        person = Person.find_by_avature_id(key.to_i)
        if person then
          updated_count += 1
          person.update_attributes(value)
        else
          created_count += 1
          value[:avature_id] = key
          person = Person.new(value)
          person.save()
        end
        people << person
      end
    end
    puts "Updated #{updated_count} people and created #{created_count} people"
    people
  end
end