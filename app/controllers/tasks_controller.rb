class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_list

  def index
    @tasks = @list.tasks.all
  end

  def show
    @task = @list.tasks.find(params[:id])
    respond_to(&:js)
  end

  def new
    @task = Task.new
    respond_to(&:js)
  end

  def edit
    respond_to(&:js)
  end

  def create
    @task = @list.tasks.new(task_params)

    respond_to do |format|  
      if @task.save
        # format.html { redirect_to root_path, notice: 'Task was successfully created.' }
        format.js
        format.json { render :show, status: :created, location: @task }
      else
        # format.html { redirect_to root_path, notice: "#{@task.errors.full_messages.first}" }
        format.js
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        # format.html { redirect_to root_path, notice: 'Task was successfully updated.' }
        format.js
        format.json { render :show, status: :ok, location: @task }
      else
        # format.html { redirect_to root_path, notice: "#{@task.errors.full_messages.first}" }
        format.js 
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def set_list
      @list = List.find(params[:list_id])
    end

    def task_params
      params.require(:task).permit(:content, :status, :important, :list_id)
    end
end