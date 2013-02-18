class RecordsToCleanController < ApplicationController
  def index
  end

  def strange_country_city_combos
    @people = Person.for_js("this.countries.length != this.cities.length || this.countries.length == 0 || this.cities.length == 0")

    respond_to do |format|
      format.html
      format.json { render json: @people }
    end
  end
end
