class FilesController < ApplicationController
  before_action :set_file, only: [:show, :edit, :update, :destroy]
  before_action :set_list
  # before_action :set_client_timezone, only: [:create, :update]
  
  rescue_from Timezone::Error::GeoNames, with: :timezone_connection_problems
  rescue_from ActionController::ParameterMissing, with: :empty_file_error

  def index
    @files = @list.files.order(:status, important: :desc)
  end

  def show; end

  def new
    @file = File.new
    respond_to(&:js)
  end

  def edit
    respond_to(&:js)
  end

  def create
    @file = @list.files.new(file_params)
    #@file.timezone = @client_timezone
    respond_to do |format|  
      if @file.save
        format.js
        format.json { render :show, status: :created, location: @file }
      else
        set_flash_error(@file)
        format.js { render 'shared/notice.js.erb' }
        format.json { render json: @file.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @file.assign_attributes(file_params)
    @file.timezone = @client_timezone
    respond_to do |format|
      if @file.save
        format.js
        format.json { render :show, status: :ok, location: @file }
      else
        set_flash_error(@file)
        format.js { render 'shared/notice.js.erb' }
        format.json { render json: @file.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @file.destroy
    respond_to do |format|
      # format.html { redirect_to root_path, notice: 'File was successfully destroyed.' }
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

    def set_file
      @file = File.find(params[:id])
    end

    def set_list
      @list = List.find(params[:list_id])
    end

    def file_params
      params.require(:file).permit(:content, :status, :important, :deadline, :file, :list_id)
    end

    def timezone_connection_problems
      flash[:alert] = "We have some problems with connecton, please try again later."
      respond_to do |format| 
        format.js { render 'shared/notice.js.erb' }
      end
    end

    def empty_file_error
      flash[:alert] = "File must exist!"
      respond_to do |format|
        format.js { render 'shared/notice.js.erb' }
      end
    end
end