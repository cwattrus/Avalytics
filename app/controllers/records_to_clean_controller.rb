class RecordsToCleanController < ApplicationController
  def index
  end

  def strange_country_city_combos
    @people = Person.for_js("this.countries.length != 1 || this.cities.length != this.countries.length")

    respond_to do |format|
      format.html
      format.json { render json: @people }
    end
  end

  def gender
    @person = Person.where(:female => nil).sample
  end

  def fix_gender
    person = Person.find(params[:id])
    person.female = params[:gender] == "female" ? true : false
    person.save()
    redirect_to records_to_clean_gender_path
  end

  def race
    @person = Person.where(:race => nil).sample
  end

  def fix_race
    person = Person.find(params[:id])
    person.race = params[:race]
    person.save()
    redirect_to records_to_clean_race_path
  end
end
