class PeopleFilterPresenter
  def step_options
    @step_options ||= Person.distinct(:step).sort
  end

  def source_options
    @source_options ||= Person.distinct(:source).sort
  end

  def job_title_options
    @job_title_options ||= Person.distinct(:job_title).sort
  end
end