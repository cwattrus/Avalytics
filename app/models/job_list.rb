require 'open-uri'

class JobList
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

  EXPECTED_COLMNS = [
    "Person ID",
    "First name",
    "Last name",
    "Creation date",
    "Last update",
    "Grade",
    "Graduate Questionnaire (Max Score = 50)",
    "Home countries",
    "Home cities",
    "Linked Job step",
    "Referred by",
    "Responsible Recruiter",
    "Attached files and forms",
    "Source"]

  include Mongoid::Document

  field :recruiting_region, type: String
  field :job_title, type: String
  field :url, type: String

  def self.update_people
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
    people_to_delete = Person.where(:id.nin => people.map(&:id))
    puts "#{Time.now} - Deleting #{people_to_delete.count} people because they are out of date"
    people_to_delete.delete
  end

  def scrape_people
    doc = Nokogiri::HTML(open(self.url))
    rows = doc.search("table tr")
    if rows.first.search("th").map(&:content) == EXPECTED_COLMNS then
      people = {}
      rows[1..-1].each do |row|
        persons_values = row.search("td")
        people[persons_values[0].content]  = {
          :first_name => clear_nbsp(persons_values[1].content).strip,
          :last_name => clear_nbsp(persons_values[2].content).strip,
          :creation_date => persons_values[3].content,
          :last_updated_date => persons_values[4].content,
          :grade => clear_nbsp(persons_values[5].content).strip,
          :questionaire_score => clear_nbsp(persons_values[6].content).strip,
          :countries => make_array_and_remove_home_for(persons_values[7].content),
          :cities => make_array_and_remove_home_for(persons_values[8].content),
          :step => clear_nbsp(persons_values[9].content).strip,
          :referred_by => clear_nbsp(persons_values[10].content).strip,
          :recruiter => clear_nbsp(persons_values[11].content).strip,
          :attached_files_and_forms => clear_nbsp(persons_values[12].content).strip,
          :source => clear_nbsp(persons_values[13].content).strip,
          :job_title => clear_nbsp(self.job_title).strip,
          :recruiting_region => clear_nbsp(self.recruiting_region).strip
        }
      end
      people
    else
      raise "Couldn't scrape #{self.url} because columns were not as expected"
    end
  end

  private
  def clear_nbsp(value)
    value.gsub("\u00a0"," ")
  end

  def make_array_and_remove_home_for(value)
    values = clear_nbsp(value).split("[home] ").map(&:strip).reject {|elem| elem == ""}
    values.map do |item|
      item[-1] == "," ? item[0..-2] : item
    end.reject(&:nil?)
  end
end