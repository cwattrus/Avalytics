class PeopleController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]
  # GET /people
  # GET /people.json
  def index
    unless user_signed_in?
      return redirect_to new_user_session_path
    end

    @people = Person.all

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
