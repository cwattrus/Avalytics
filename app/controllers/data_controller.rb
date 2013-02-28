class DataController < ApplicationController
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

    respond_to do |format|
      format.json { render json: @jobs_with_grades_and_steps}
    end
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

    respond_to do |format|
      format.json { render json: @jobs_with_grades_and_steps}
    end
  end

  def gender_pie
    @genders = [
      {
        :key => "Genders",
        :values => [
          {
            :label => "Female",
            :value => Person.where(:female => true).count
          },
          {
            :label => "Male",
            :value => Person.where(:female => false).count
          },
          {
            :label => "Unknown",
            :value => Person.where(:female => nil).count
          }
        ]
      }
    ]

    respond_to do |format|
      format.json { render json: @genders}
    end
  end
end