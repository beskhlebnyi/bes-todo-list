class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_list
  before_action :set_client_timezone, only: [:create, :update]
  
  rescue_from Timezone::Error::GeoNames, with: :timezone_connection_problems

  def index
    @tasks = @list.tasks.order(:status, important: :desc)
  end

  def show; end

  def new
    @task = Task.new
    respond_to(&:js)
  end

  def edit
    respond_to(&:js)
  end

  def create
    @task = @list.tasks.new(task_params)
    @task.timezone = @client_timezone
    respond_to do |format|  
      if @task.save
        format.js
        format.json { render :show, status: :created, location: @task }
      else
        set_flash_error(@task)
        format.js { render 'shared/notice.js.erb' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    puts "HERE IT IS!!!-----------------------------------"
    @task.assign_attributes(task_params)
    @task.timezone = @client_timezone
    respond_to do |format|
      if @task.save
        format.js
        format.json { render :show, status: :ok, location: @task }
      else
        set_flash_error(@task)
        format.js { render 'shared/notice.js.erb' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      # format.html { redirect_to root_path, notice: 'Task was successfully destroyed.' }
      format.js
      format.json { head :no_content }
    end
  end

  private
    def set_client_timezone
      loc = request.location
      lat, lng = loc.latitude, loc.longitude 
      lat = 50 if lat == 0
      lng = 30 if lng == 0
      
      @client_timezone = Timezone.lookup(lat, lng).name
    end

    def set_task
      @task = Task.find(params[:id])
    end

    def set_list
      @list = List.find(params[:list_id])
    end

    def task_params
      params.require(:task).permit(:content, :status, :important, :deadline, :file, :list_id)
    end

    def timezone_connection_problems
      @notice = "We have some problems with connecton, please try again later."
      respond_to do |format| 
        format.js { render 'shared/notice.js.erb' }
      end
    end
end