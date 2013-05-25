class ReportsController < ApplicationController
  def progress_aggregation
  end

  def sunburst
  end

  def bubbles
  end

  def genders
    @job_titles = JobList.distinct(:job_title)
  end

  def races
    @job_titles = JobList.distinct(:job_title)
  end

  def map
  end
end