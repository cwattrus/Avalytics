class DataController < ApplicationController
  def progress_aggregation_horizontal_bar
    all_people = Person.all
    people_label_value_pairs = []
    people_label_value_pairs << ["Hired", all_people.where(:hired => true).count()]
    people_label_value_pairs << ["Offered", all_people.where(:offered => true).count()]
    people_label_value_pairs << ["Office Interviewed", all_people.where(:office_interviewed => true).count()]
    people_label_value_pairs << ["Code Reviewed", all_people.where(:code_reviewed => true).count()]
    people_label_value_pairs << ["Phone Screened", all_people.where(:phone_screened => true).count()]
    people_label_value_pairs << ["Total", all_people.count()]

    render json: horizontal_bar(people_label_value_pairs)
  end

  def people_with_location
    render json: Person.where(:location.ne => nil)
  end

  def jobs_with_grades_with_steps_bubbles
    jobs_with_grades_and_steps = {
      :name => "",
      :children => Person.distinct(:job_title).map do |title|
        title_count = Person.where(job_title: title).count
        {
          :name => "#{title_count} #{title}",
          :count => title_count,
          :children => Person.where(job_title: title).distinct(:grade).map do |grade|
            display_grade = {
              "" => "Unclassified",
              "Consultant - Graduate" => "Grad",
              "Consultant" => "Consultant",
              "Senior Consultant" => "Senior",
              "Lead Consultant" => "Lead",
              "Principal Consultant" => "Principal"
            }[grade] || grade
            title_grade_count = Person.where(job_title: title, grade: grade).count
            {
              :name => "#{title_grade_count} #{display_grade}",
              :count => title_grade_count,
              :children => Person.where(job_title: title, grade: grade).distinct(:step).map do |step|
                title_grade_step_count = Person.where(job_title: title, grade: grade, step: step).count
                {
                  :name => "#{title_grade_step_count} #{step}",
                  :count => title_grade_step_count
                }
              end
            }
          end
        }
      end
    }

    render json: jobs_with_grades_and_steps
  end

  def jobs_with_grades_with_steps_sunburst
    jobs_with_grades_and_steps = Person.distinct(:job_title).map do |title|
      title_count = Person.where(job_title: title).count
      {
        :name => "#{title_count} #{title}",
        :count => title_count,
        :children => Person.where(job_title: title).distinct(:grade).map do |grade|
          display_grade = {
            "" => "Unclassified",
            "Consultant - Graduate" => "Grad",
            "Consultant" => "Consultant",
            "Senior Consultant" => "Senior",
            "Lead Consultant" => "Lead",
            "Principal Consultant" => "Principal"
          }[grade] || grade
          title_grade_count = Person.where(job_title: title, grade: grade).count
          {
            :name => "#{title_grade_count} #{display_grade}",
            :count => title_grade_count,
            :children => Person.where(job_title: title, grade: grade).distinct(:step).map do |step|
              title_grade_step_count = Person.where(job_title: title, grade: grade, step: step).count
              {
                :name => "#{title_grade_step_count} #{step}",
                :count => title_grade_step_count
              }
            end
          }
        end
      }
    end

    render json: jobs_with_grades_and_steps
  end

  def gender_pie
    render json: pie({"Female" => true, "Male" => false}, :female)
  end

  def race_pie
    race_labels = {}
    Person::RACES.each {|race| race_labels[race] = race}
    render json: pie(race_labels, :race)
  end

  private

  def pie(label_to_value_pairs, attribute)
    job_title = params[:job_title]

    [
      {
        :key => "Pie Data",
        :values => [{
          :label => "Unknown",
          :value => job_title ? Person.where(:job_title => job_title, attribute => nil).count : Person.where(attribute => nil).count
        }] + label_to_value_pairs.map do |label, value|
          {
            :label => label,
            :value => job_title ? Person.where(:job_title => job_title, attribute => value).count : Person.where(attribute => value).count
          }
        end
      }
    ]
  end

  def horizontal_bar(label_value_pairs)
    [
      {
        "key" => 'Horizontal Bar Data',
        "color" => '#2ca02c',
        "values" => label_value_pairs.map do |label_and_values|
          { "label" => label_and_values[0],
            "value" => label_and_values[1]}
        end
      }
    ]
  end
end