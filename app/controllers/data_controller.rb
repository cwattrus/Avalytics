class DataController < ApplicationController
  def people_with_location
    @people = Person.where(:location.ne => nil)

    respond_to do |format|
      format.json { render json: @people}
    end
  end

  def jobs_with_grades_with_steps_bubbles
    @jobs_with_grades_and_steps = {
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

    render json: @jobs_with_grades_and_steps
  end

  def jobs_with_grades_with_steps_sunburst
    @jobs_with_grades_and_steps = Person.distinct(:job_title).map do |title|
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

    render json: @jobs_with_grades_and_steps
  end

  def gender_pie
    job_title = params[:job_title]
    if job_title
      female_count = Person.where(:female => true, :job_title => job_title).count
      male_count = Person.where(:female => false, :job_title => job_title).count
      unknown_count = Person.where(:female => nil, :job_title => job_title).count
    else
      female_count = Person.where(:female => true).count
      male_count = Person.where(:female => false).count
      unknown_count = Person.where(:female => nil).count
    end
    @genders = [
      {
        :key => "Genders",
        :values => [
          {
            :label => "Unknown",
            :value => unknown_count
          },
          {
            :label => "Female",
            :value => female_count
          },
          {
            :label => "Male",
            :value => male_count
          }
        ]
      }
    ]

    render json: @genders
  end

  def race_pie
    job_title = params[:job_title]

    values = Person::RACES.map do |race|
      {
        :label => race,
        :value => job_title ? Person.where(:job_title => job_title, :race => race).count : Person.where(:race => race).count
      }
    end

    values = [{
      :label => "Unknown",
      :value => job_title ? Person.where(:job_title => job_title, :race => nil).count : Person.where(:race => nil).count
    }] + values

    @races = [
      {
        :key => "Races",
        :values => values
      }
    ]

    render json: @races
  end
end