class ReportsController < ApplicationController

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