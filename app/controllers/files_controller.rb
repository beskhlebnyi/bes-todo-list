class DocumentsController < ApplicationController
  before_action :set_file, only: [:show, :edit, :update, :destroy]
  before_action :set_list

  rescue_from ActionController::ParameterMissing, with: :empty_file_error

  def index
    @files = @list.files.all
  end

  def show; end

  def new
    @file = Document.new
    respond_to(&:js)
  end

  def edit
    respond_to(&:js)
  end

  def create
    @file = @list.files.new(file_params)
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
      # format.html { redirect_to root_path, notice: 'Document was successfully destroyed.' }
      format.js
      format.json { head :no_content }
    end
  end

  private

    def set_file
      @file = Document.find(params[:id])
    end

    def set_list
      @list = List.find(params[:list_id])
    end

    def file_params
      params.require(:file).permit(:file, :list_id)
    end

    def empty_file_error
      flash[:alert] = "Document must exist!"
      respond_to do |format|
        format.js { render 'shared/notice.js.erb' }
      end
    end
end