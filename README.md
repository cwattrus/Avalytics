Avalytics
=========

Analytics for Avature data. Helping recruiters, recruit.

Job codes
=========

* Applications Developer - 1067
* Business Analyst - 1145
* Pan-African Graduate Software Developers - 1160
* Quality Assurance Analyst - 1070
* TechOps Lead - 1131
* What's the Story with ThoughtWorks South Africa? - 888

Getting your machine setup
==========================

1. Install ruby-1.9.3-p327
1. Add Avalytics gemset
1. rvm use ruby-1.9.3-p327@Avalytics
1. bundle install
1. brew install mongodb
1. follow the prompt after mongodb installs to make it run as a service
1. rails c
1. User.new(:email => "<EMAIL>", :password => "<PASSWORD>", :password_confirmation => "<PASSWORD>").save!
1. rails s
1. Add job lists at http://localhost:3000/job_lists
1. rake ingest:people
