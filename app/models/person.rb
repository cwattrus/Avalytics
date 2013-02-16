class Person
  include MongoMapper::Document

  key :avature_id, Integer
  key :first_name, String
  key :last_name, String
  key :creation_date, Date
  key :last_updated_date, Date
  key :grade, String
  key :questionaire_score, Integer
  key :countries, Array
  key :cities, Array
  key :step, String
  key :referred_by, String
  key :recruiter, String
  key :attached_files_and_forms, String
  key :source, String
  key :job_title, String
end