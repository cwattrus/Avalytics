class ReportsController < ApplicationController

  def sunburst
  end

  def bubbles
  end

  def genders
    @job_lists = JobList.all
  end
end