class RecordsToCleanController < ApplicationController
  has_scope :by_step, type: :array
  has_scope :by_source, type: :array
  has_scope :by_job_title, type: :array

  def strange_country_city_combos
    @people = apply_scopes(Person).strange_country_city_combos
    @people_filter = PeopleFilter.new(by_step: params[:by_step], by_source: params[:by_source], by_job_title: params[:by_job_title])

    respond_to do |format|
      format.html
      format.json { render json: @people }
    end
  end

  def gender_sample
    redirect_to records_to_clean_gender_path(Person.where(:female => nil).sample)
  end

  def gender
    @person = Person.find(params[:id])
  end

  def fix_gender
    person = Person.find(params[:id])
    person.female = params[:gender] == "female" ? true : false
    person.save()
    redirect_to records_to_clean_gender_sample_path
  end

  def race_sample
    redirect_to records_to_clean_race_path(Person.where(:race => nil).sample)
  end

  def race
    @person = Person.find(params[:id])
  end

  def fix_race
    person = Person.find(params[:id])
    person.race = params[:race]
    person.save()
    redirect_to records_to_clean_race_sample_path
  end
end
