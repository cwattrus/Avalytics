class JobList
  include MongoMapper::Document

  key :job_title, String
  key :url, String
end