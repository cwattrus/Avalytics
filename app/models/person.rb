class Person
  include Mongoid::Document
  RACES = [
    "Black",
    "White",
    "Colored",
    "Asian",
    "Indian/Pakistani",
    "Pacific Islander",
    "Other"
  ]

  field :avature_id, type: Integer
  field :first_name, type: String
  field :last_name, type: String
  field :creation_date, type: Date
  field :last_updated_date, type: Date
  field :grade, type: String
  field :questionaire_score, type: Integer
  field :countries, type: Array
  field :cities, type: Array
  field :step, type: String
  field :referred_by, type: String
  field :recruiter, type: String
  field :attached_files_and_forms, type: String
  field :source, type: String
  field :job_title, type: String
  field :female, type: Boolean
  field :race, type: String
  field :location, type: Array

  scope :bad_country_city_combos, for_js("this.countries.length != 1 || (this.cities.length > this.countries.length)")
  scope :strange_country_city_combos, for_js("this.countries.length != 1 || (this.cities.length > this.countries.length) || this.location == null")

  def gender
    if self.female == true
      "Female"
    elsif self.female == false
      "Male"
    else
      "Unknown"
    end
  end

  def display_location
     "#{self.cities.first}, #{self.countries.first}" unless self.countries.empty?
  end

  def location_url
    address = self.countries.first
    address += self.cities.first unless self.cities.empty?
    "http://maps.googleapis.com/maps/api/geocode/xml?address=#{URI::encode(address)}&sensor=false"
  end

  def hired?
    self.step.downcase == "hired"
  end

  def offered?
    hired? ||
    ["offer", "declined offer"].include?(self.step.downcase)
  end

  def office_interviewed?
    offered? ||
    self.step.downcase == "office interview" ||
    self.attached_files_and_forms.downcase =~ /(assessment scores|cultural interview|paired code interview|technical interview|management interview)/
  end
end