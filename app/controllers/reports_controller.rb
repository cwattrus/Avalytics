class ReportsController < ApplicationController
  def progress_aggregation
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