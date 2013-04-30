require 'open-uri'

namespace :ingest do
  task :people => :environment do
    people = []
    updated_count = 0
    created_count = 0
    JobList.all.each do |job_list|
      puts "#{Time.now} - Ingesting #{job_list.job_title} from #{job_list.url}"
      scraped = job_list.scrape_people
      puts "#{Time.now} - Found #{scraped.size} people in job"
      scraped.each do |key, value|
        Mongoid.raise_not_found_error = false
        person = Person.find_by(:avature_id => key.to_i)
        if person then
          updated_count += 1
          person.update_attributes(value)
        else
          created_count += 1
          value[:avature_id] = key
          person = Person.new(value)
        end
        person.setup_past_states
        person.save()
        people << person
      end
    end
    puts "#{Time.now} - Updated #{updated_count} people and created #{created_count} people"
    people
  end

  task :locations => :environment do
    ids_to_leave_out = Person.bad_country_city_combos.distinct(:id)
    count = Person.where(location: nil, :id.nin => ids_to_leave_out).count
    puts "#{Time.now} - Getting location information for #{count} people"
    count = 0
    Person.where(location: nil, :id.nin => ids_to_leave_out).each do |person|
      puts "#{Time.now} - Looking for location of #{person.first_name} #{person.last_name}"
      doc = Nokogiri::XML(open(person.location_url))
      if doc.xpath("//GeocodeResponse/status").text == "OK"
        lat = doc.xpath("//GeocodeResponse/result/geometry/location/lat")[0].text.to_f
        lng = doc.xpath("//GeocodeResponse/result/geometry/location/lng")[0].text.to_f
        person.location = [lat, lng]
        person.save
        count += 1
      end
    end
    puts "#{Time.now} - Got location information for #{count} people"
  end
end