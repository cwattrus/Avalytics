Avalytics
=========

Analytics for Avature data. Helping recruiters, recruit.

Job codes:
* Applications Developer - 1067
* Business Analyst - 1145
* Pan-African Graduate Software Developers - 1160
* Quality Assurance Analyst - 1070
* TechOps Lead - 1131
* What's the Story with ThoughtWorks South Africa? - 888

Getting your machine setup
==========================

# Install ruby-1.9.3-p327
# Add Avalytics gemset
# rvm use ruby-1.9.3-p327@Avalytics
# bundle install
# brew install mongodb
# follow the prompt after mongodb installs to make it run as a service
# rails c
# User.new(:email => "<EMAIL>", :password => "<PASSWORD>", :password_confirmation => "<PASSWORD>").save!
# rails s
# Add job lists at http://localhost:3000/job_lists
# rake ingest:people
