class Person
  include Mongoid::Document

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

  def gender
    if self.female == true
      "Female"
    elsif self.female == false
      "Male"
    else
      "Unknown"
    end
  end
end