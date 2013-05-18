class PeopleController < ApplicationController
  before_filter :authenticate_user!
  has_scope :by_step, type: :array
  has_scope :by_source, type: :array
  has_scope :by_job_title, type: :array

  # GET /people
  # GET /people.json
  def index
    @people = apply_scopes(Person).all
    @people_filter = PeopleFilter.new(by_step: params[:by_step], by_source: params[:by_source], by_job_title: params[:by_job_title])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @people }
    end
  end

  # GET /people/1
  # GET /people/1.json
  def show
    @person = Person.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @person }
    end
  end
end
