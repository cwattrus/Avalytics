class JobListsController < ApplicationController
  before_filter :authenticate_user!
  def refresh_people_data
    JobList.update_people
    Person.update_locations
    redirect_to job_lists_path, notice: 'The data is now up-to-date.'
  end

  # GET /job_lists
  # GET /job_lists.json
  def index
    @job_lists = JobList.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @job_lists }
    end
  end

  # GET /job_lists/1
  # GET /job_lists/1.json
  def show
    @job_list = JobList.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @job_list }
    end
  end

  # GET /job_lists/new
  # GET /job_lists/new.json
  def new
    @job_list = JobList.new
    @existing_job_titles = JobList.distinct(:job_title)
    @existing_recruiting_regions = JobList.distinct(:recruiting_region)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @job_list }
    end
  end

  # GET /job_lists/1/edit
  def edit
    @job_list = JobList.find(params[:id])
    @existing_job_titles = JobList.distinct(:job_title)
    @existing_recruiting_regions = JobList.distinct(:recruiting_region)
  end

  # POST /job_lists
  # POST /job_lists.json
  def create
    @job_list = JobList.new(params[:job_list])

    respond_to do |format|
      if @job_list.save
        format.html { redirect_to @job_list, notice: 'Job list was successfully created.' }
        format.json { render json: @job_list, status: :created, location: @job_list }
      else
        format.html { render action: "new" }
        format.json { render json: @job_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /job_lists/1
  # PUT /job_lists/1.json
  def update
    @job_list = JobList.find(params[:id])

    respond_to do |format|
      if @job_list.update_attributes(params[:job_list])
        format.html { redirect_to @job_list, notice: 'Job list was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @job_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /job_lists/1
  # DELETE /job_lists/1.json
  def destroy
    @job_list = JobList.find(params[:id])
    @job_list.destroy

    respond_to do |format|
      format.html { redirect_to job_lists_url }
      format.json { head :no_content }
    end
  end
end
