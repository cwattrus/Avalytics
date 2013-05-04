class ReportsController < ApplicationController
  def progress_aggregation
    all_people = Person.all
    @total_count = all_people.count()
    @phone_screened_count = all_people.where(:phone_screened => true).count()
    @code_reviewed_count = all_people.where(:code_reviewed => true).count()
    @office_interviewed_count = all_people.where(:office_interviewed => true).count()
    @offered_count = all_people.where(:offered => true).count()
    @hired_count = all_people.where(:hired => true).count()
  end

  def sunburst
  end

  def bubbles
  end

  def genders
    @job_lists = JobList.all
  end

  def races
    @job_lists = JobList.all
  end

  def map
  end
end