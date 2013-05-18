module ApplicationHelper
  def progress_tracker_class(person, attribute)
    incomplete_step_class = "progress-tracker-todo"
    incomplete_step_class = "progress-tracker-hold" if person.step == "Hold"
    incomplete_step_class = "progress-tracker-rejected" if person.step == "Rejected"
    person.send(attribute.to_s + "?") ? "progress-tracker-done" : incomplete_step_class
  end
end
