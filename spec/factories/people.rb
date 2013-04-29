# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person do
    avature_id 1232343
    first_name "Patrick"
    last_name "Turley"
    creation_date "2013-04-29"
    last_updated_date "2013-04-29"
    countries ["South Africa"]
    cities ["Johannesburg"]
    location [-26.2041028, 28.0473051]
    grade "Lead Consultant"
    questionaire_score 50
    step "Hired"
    referred_by "Andy Slocum"
    recruiter "Jeff Smith"
    attached_files_and_forms "Phone Screen, Work Authorization"
    source "Word of mouth"
    job_title "Application Developer"
    female false
    race "White"
  end
end
