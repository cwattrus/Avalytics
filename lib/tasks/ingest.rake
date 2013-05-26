require 'open-uri'

namespace :ingest do
  task :people => :environment do
    JobList.update_people
    Person.update_locations
  end
end